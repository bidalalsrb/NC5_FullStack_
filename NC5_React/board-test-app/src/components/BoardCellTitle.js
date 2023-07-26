import React from 'react';
import styled from "styled-components";

const BoardCellBlock = styled.div`
  text-align: center;
  font-size: 1.25rem;
  line-height: 1.5;
  border: 1px solid black;
  font-weight: bold;
`
const BoardListItemCellBlock = styled.div`
  display: flex;
  width: 800px;
  justify-content: center;
  align-items: center;
  margin: 0 auto;
  background-color: #ff6b6b;
`
function BoardCellTitle(props) {
    return (
        <BoardListItemCellBlock>
            <BoardCellBlock style={{width: '40px'}}>No</BoardCellBlock>
            <BoardCellBlock style={{width: '150px'}}> 글 제목</BoardCellBlock>
            <BoardCellBlock style={{width: '300px'}}> 글 내용</BoardCellBlock>
            <BoardCellBlock style={{width: '150px'}}> 글 작성자</BoardCellBlock>
            <BoardCellBlock style={{width: '300px'}}> 작성 날짜</BoardCellBlock>
        </BoardListItemCellBlock>
    );
}

export default BoardCellTitle;