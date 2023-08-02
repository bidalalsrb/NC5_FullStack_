import React from 'react';

const Board = () => {
  return (
    <div>
      <div
        style={{
          display: 'flex',
          flexDirection: 'column',
          justifyContent: 'center',
          alignItems: 'center',
        }}
      >
        <h3>게시글 상세</h3>
        <form id="updateForm">
          <input name="boardNo" id="boardNo" />
          <input name="boardRegdate" id="boardRegdate" />
          <input name="boardCnt" id="boardCnt" />
          <input name="originFiles" id="originFiles" />
          <table style={{ borderCollapse: 'collapse', border: '1px' }}>
            <tr>
              <td style={{ background: 'skyblue', width: '70px' }}>제목</td>
              <td style={{ textAlign: 'left' }}>
                <input type="text" name="boardTitle" id="boardTitle" />
              </td>
            </tr>
            <tr>
              <td style={{ background: 'skyblue' }}>작성자</td>
              <td style={{ textAlign: 'left' }}>
                <input
                  type="text"
                  name="boardWriter"
                  id="boardWriter"
                />
              </td>
            </tr>
            <tr>
              <td style={{ background: 'skyblue' }}>내용</td>
              <td style={{ textAlign: 'left' }}>
                <textarea
                  name="boardContent"
                  id="boardContent"
                  cols="40"
                  rows="10"
                ></textarea>
              </td>
            </tr>
            <tr>
              <td style={{ background: 'skyblue' }}>작성일</td>
              <td style={{ textAlign: 'left' }}></td>
            </tr>
            <tr>
              <td style={{ background: 'skyblue' }}>조회수</td>
              <td style={{ textAlign: 'left' }}></td>
            </tr>
            <tr>
              <td style={{ background: 'skyblue', width: '70px' }}>첨부파일</td>
              <td style={{ textAlign: 'left' }}>
                <div id="image_preview">
                  <input type="file" id="btnAtt" name="uploadFiles" multiple />
                  <input
                    type="file"
                    id="changedFiles"
                    name="changedFiles"
                    style="display:none;"
                    multiple
                  />
                  <p style="color: red; font-size:0.9rem;">
                    파일을 변경하려면 사진을 파일을 다운로드하려면 파일명을
                    클릭하세요.
                  </p>
                  <div id="attZone">
                    <div
                      style={{
                        display: 'inline-block',
                        position: 'relative',
                        width: '150px',
                        height: '120px',
                        margin: '5px',
                        border: '1px solid #00f',
                        zIndex: '1',
                      }}
                    >
                      <input type="hidden" />
                      <input type="hidden" />
                      <input type="hidden" />
                      <input type="file" style={{ display: 'none' }} />

                      <input
                        type="hidden"
                        id="boardFileCnt"
                        name="boardFileCnt"
                      />
                      <img
                        style={{
                          width: '100%',
                          height: '100%',
                          zIndex: 'none',
                          cursor: 'pointer',
                        }}
                        class="fileImg"
                      />

                      <img
                        src="/images/defaultFileImg.png"
                        style={{
                          width: '100%',
                          height: '100%',
                          zIndex: 'none',
                          cursor: 'pointer',
                        }}
                        class="fileImg"
                      />
                      <input
                        type="button"
                        class="btnDel"
                        value="x"
                        style={{
                          width: '30px',
                          height: '30px',
                          position: 'absolute',
                          right: '0px',
                          bottom: '0px',
                          zIndex: '999',
                          backgroundColor: 'rgba(255, 255, 255, 0.1)',
                          color: '#f00',
                        }}
                        onclick="fnImgDel(event)"
                      />
                      <p
                        style={{
                          display: 'inline-block',
                          fontSize: ' 8px',
                          cursor: 'pointer',
                        }}
                      ></p>
                    </div>
                  </div>
                </div>
              </td>
            </tr>
            <tr id="btnWrap">
              <td colspan="2" align="center">
                <button type="button" id="btnUpdate">
                  수정
                </button>
              </td>
            </tr>
          </table>
        </form>
        <hr />
        <Link to="/insert-board.do">글 등록</Link>
        <Link to="#" id="btnDelete">
          글 삭제
        </Link>
        <Link to="/board/board-list">글 목록</Link>
      </div>
    </div>
  );
};

export default Board;
