import React, {useEffect, useState} from 'react';
import axios from "axios";
import BoardListItem from "./BoardListItem";
import styled from "styled-components";
import BoardCellTitle from "./BoardCellTitle";

const BoardListBlock = styled.div`
  width: 100%;

`


function BoardList() {
    const [boardList, setBoardList] = useState([]);
    useEffect(() => {
            const getBoardList = async () => {
                try {
                    const response = await axios.get('http://localhost:9090/api/board-list')
                    console.log(response)
                    setBoardList(() => response.data.pageItems.content)
                } catch (e) {
                    console.log(e)
                }
            }
            getBoardList();
        }
        ,
        []
    )

    return (
        <BoardListBlock>
            {/*<button onClick={boardList}>데이터 가져오기</button>*/}
            {/*<textarea value={JSON.stringify(boardList)}></textarea>*/}
            <BoardCellTitle></BoardCellTitle>
            {boardList && boardList.map((b) =>
                (<BoardListItem key={b.boardNo} board={b}></BoardListItem>))}
        </BoardListBlock>
    );
}

export default BoardList;