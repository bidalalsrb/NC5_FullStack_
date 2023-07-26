import React from 'react';
import styled from "styled-components";

const BoardListItemBlock = styled.div`
  display: flex;
  width: 800px;
  justify-content: center;
  align-items: center;
  margin: 0 auto;
`

const BoardCell = styled.div`
  text-align: center;
  font-size: 1.125rem;
  line-height: 1.6;
  border: 1px solid black;
`

function BoardListItem({board}) {
    return (

        <BoardListItemBlock>
            <BoardCell style={{width:'40px'}}>{board.boardNo}</BoardCell>
            <BoardCell style={{width:'150px'}}> {board.boardTitle}</BoardCell>
            <BoardCell style={{width:'300px'}}> {board.boardContent}</BoardCell>
            <BoardCell style={{width:'150px'}}> {board.boardWriter}</BoardCell>
            <BoardCell style={{width:'300px'}}> {board.boardRegdate}</BoardCell>
            <br/>
        </BoardListItemBlock>
    );
}

export default BoardListItem;