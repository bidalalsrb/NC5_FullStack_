package com.bit.springboard.controller;

import com.bit.springboard.common.FileUtils;
import com.bit.springboard.dto.BoardDTO;
import com.bit.springboard.dto.BoardFileDTO;
import com.bit.springboard.dto.ResponseDTO;
import com.bit.springboard.entity.Board;
import com.bit.springboard.entity.BoardFile;
import com.bit.springboard.entity.CustomUserDetails;
import com.bit.springboard.service.BoardService;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import java.io.File;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

//화면단으로 이동할 때는 ModelAndView객체를 리턴해서 처리
@RestController
@RequestMapping("/board")
public class BoardController {
    private BoardService boardService;

    @Value("${file.path}")
    String attachPath;

    @Autowired
    public BoardController(BoardService boardService) {
        this.boardService = boardService;
    }

    @GetMapping("/board-list")
    public ModelAndView getBoardList(
            @PageableDefault(page=0, size=10) Pageable pageable,
            //security에 있는 authentication에 접근
            @AuthenticationPrincipal CustomUserDetails customUserDetails) {
        customUserDetails.getUser().getUserId();
        ModelAndView mv = new ModelAndView();

        Page<Board> pageBoardList = boardService.getBoardList(pageable);

        Page<BoardDTO> pageBoardDTOList = pageBoardList.map(pageBoard ->
                BoardDTO.builder()
                        .boardTitle(pageBoard.getBoardTitle())
                        .boardCnt(pageBoard.getBoardCnt())
                        .boardContent(pageBoard.getBoardContent())
                        .boardWriter(pageBoard.getBoardWriter())
                        .boardRegdate(pageBoard.getBoardRegdate().toString())
                        .boardNo(pageBoard.getBoardNo())
                        .build()
        );

        mv.addObject("boardList", pageBoardDTOList);
        mv.setViewName("board/getBoardList.html");

        return mv;
    }

    @PostMapping("/board")
    public ResponseEntity<?> insertBoard(BoardDTO boardDTO,
                                         MultipartFile[] uploadFiles,
                                         HttpServletRequest request) {
        ResponseDTO<Map<String, String>> responseDTO =
                    new ResponseDTO<Map<String, String>>();
//        String attachPath =
//                request.getSession().getServletContext().getRealPath("/")
//                + "/upload/";

        File directory = new File(attachPath);

        if(!directory.exists()) {
            directory.mkdir();
        }

        List<BoardFile> uploadFileList = new ArrayList<BoardFile>();

        try {
            //BoardEntity에 지정한 boardRegdate의 기본값은
            //기본생성자 호출할 때만 기본값으로 지정되는데
            //builder()는 모든 매개변수를 갖는 생성자를 호출하기 때문에
            //boardRegdate의 값이 null값으로 들어간다.
            Board board = Board.builder()
                            .boardTitle(boardDTO.getBoardTitle())
                            .boardContent(boardDTO.getBoardContent())
                            .boardWriter(boardDTO.getBoardWriter())
                            .boardRegdate(LocalDateTime.now())
                            .build();
            System.out.println("========================"+board.getBoardRegdate());

            //파일처리
            for(int i = 0; i < uploadFiles.length; i++) {
                MultipartFile file = uploadFiles[i];

                if(file.getOriginalFilename() != null &&
                        !file.getOriginalFilename().equals("")) {
                    BoardFile boardFile = new BoardFile();

                    boardFile = FileUtils.parseFileInfo(file, attachPath);

                    boardFile.setBoard(board);

                    uploadFileList.add(boardFile);
                }
            }

            boardService.insertBoard(board, uploadFileList);

            Map<String, String> returnMap =
                    new HashMap<String, String>();

            returnMap.put("msg", "정상적으로 저장되었습니다.");

            responseDTO.setItem(returnMap);

            return ResponseEntity.ok().body(responseDTO);
        } catch(Exception e) {
            responseDTO.setStatusCode(HttpStatus.BAD_REQUEST.value());
            responseDTO.setErrorMessage(e.getMessage());

            return ResponseEntity.badRequest().body(responseDTO);
        }
    }

    @PutMapping("/board")
    public ResponseEntity<?> updateBoard(BoardDTO boardDTO,
                                         MultipartFile[] uploadFiles,
                                         MultipartFile[] changedFiles,
                                         @RequestParam("originFiles") String originFiles)
                                                                        throws Exception {
        System.out.println(originFiles);
        ResponseDTO<Map<String, String>> responseDTO =
                new ResponseDTO<Map<String, String>>();

        List<BoardFileDTO> originFileList = new ObjectMapper().readValue(originFiles,
                new TypeReference<List<BoardFileDTO>>() {});

        //DB에서 수정, 삭제, 추가 될 파일 정보를 담는 리스트
        List<BoardFile> uFileList = new ArrayList<BoardFile>();

        try {
            Board board = Board.builder()
                            .boardNo(boardDTO.getBoardNo())
                            .boardTitle(boardDTO.getBoardTitle())
                            .boardContent(boardDTO.getBoardContent())
                            .boardWriter(boardDTO.getBoardWriter())
                            .boardRegdate(
                                    LocalDateTime.parse(
                                            boardDTO.getBoardRegdate()
                                    )
                            )
                            .boardCnt(boardDTO.getBoardCnt())
                            .build();

            //파일 처리
            for(int i = 0; i < originFileList.size(); i++) {
                //수정되는 파일 처리
                if(originFileList.get(i).getBoardFileStatus().equals("U")) {
                    for(int j = 0; j < changedFiles.length; j++) {
                        if(originFileList.get(i).getNewFileName().equals(
                                changedFiles[j].getOriginalFilename())) {
                            BoardFile boardFile = new BoardFile();

                            MultipartFile file = changedFiles[j];

                            boardFile = FileUtils.parseFileInfo(file, attachPath);

                            boardFile.setBoard(board);
                            boardFile.setBoardFileNo(originFileList.get(i).getBoardFileNo());
                            boardFile.setBoardFileStatus("U");

                            uFileList.add(boardFile);
                        }
                    }
                    //삭제되는 파일 처리
                } else if(originFileList.get(i).getBoardFileStatus().equals("D")) {
                    BoardFile boardFile = new BoardFile();

                    boardFile.setBoard(board);
                    boardFile.setBoardFileNo(originFileList.get(i).getBoardFileNo());
                    boardFile.setBoardFileStatus("D");

                    //실제 파일 삭제
                    File dFile = new File(attachPath + originFileList.get(i).getBoardFileName());
                    dFile.delete();

                    uFileList.add(boardFile);
                }
            }
            //추가된 파일 처리
            if(uploadFiles.length > 0) {
                for(int i = 0; i < uploadFiles.length; i++) {
                    MultipartFile file = uploadFiles[i];

                    if(file.getOriginalFilename() != null &&
                            !file.getOriginalFilename().equals("")) {
                        BoardFile boardFile = new BoardFile();

                        boardFile = FileUtils.parseFileInfo(file, attachPath);

                        boardFile.setBoard(board);
                        boardFile.setBoardFileStatus("I");

                        uFileList.add(boardFile);
                    }
                }
            }

            boardService.updateBoard(board, uFileList);

            Map<String, String> returnMap = new HashMap<String, String>();

            returnMap.put("msg", "정상적으로 수정되었습니다.");

            responseDTO.setItem(returnMap);

            return ResponseEntity.ok().body(responseDTO);
        } catch (Exception e) {
            responseDTO.setStatusCode(HttpStatus.BAD_REQUEST.value());
            responseDTO.setErrorMessage(e.getMessage());
            return ResponseEntity.badRequest().body(responseDTO);
        }
    }

    @DeleteMapping("/board")
    public ResponseEntity<?> deleteBoard(BoardDTO boardDTO) {
        ResponseDTO<Map<String, String>> responseDTO =
                new ResponseDTO<Map<String, String>>();

        try {
            boardService.deleteBoard(boardDTO.getBoardNo());

            Map<String, String> returnMap = new HashMap<String, String>();

            returnMap.put("msg", "정상적으로 삭제되었습니다.");

            responseDTO.setItem(returnMap);

            return ResponseEntity.ok().body(responseDTO);
        } catch (Exception e) {
            responseDTO.setStatusCode(HttpStatus.BAD_REQUEST.value());
            responseDTO.setErrorMessage(e.getMessage());
            return ResponseEntity.badRequest().body(responseDTO);
        }
    }

    @GetMapping("/board/{boardNo}")
    public ModelAndView getBoard(@PathVariable int boardNo) {
        ModelAndView mv = new ModelAndView();

        Board board = boardService.getBoard(boardNo);

        BoardDTO returnBoardDTO = BoardDTO.builder()
                .boardNo(board.getBoardNo())
                .boardTitle(board.getBoardTitle())
                .boardContent(board.getBoardContent())
                .boardWriter(board.getBoardWriter())
                .boardRegdate(board.getBoardRegdate().toString())
                .boardCnt(board.getBoardCnt())
                .build();

        List<BoardFile> boardFileList = boardService.getBoardFileList(boardNo);

        List<BoardFileDTO> boardFileDTOList =
                            new ArrayList<BoardFileDTO>();

        for(BoardFile boardFile : boardFileList) {
            BoardFileDTO boardFileDTO = boardFile.EntityToDTO();
            boardFileDTOList.add(boardFileDTO);
        }

        mv.addObject("board", returnBoardDTO);
        mv.addObject("boardFileList", boardFileDTOList);
        mv.setViewName("board/getBoard.html");

        return mv;
    }

    @GetMapping("/insert-board-view")
    public ModelAndView insertBoardView() {
        ModelAndView mv = new ModelAndView();

        mv.setViewName("board/insertBoard.html");

        return mv;
    }










}
