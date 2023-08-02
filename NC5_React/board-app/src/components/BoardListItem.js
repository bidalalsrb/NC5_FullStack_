import React from 'react';
import { Link } from 'react-router-dom';
const BoardListItem = (props) => {
  const {boardNo, boardTitle, boardContent, boardWriter, boardRegdate, boardCnt} = props.board
  return (
    <tr>
      <td>{boardNo}</td>
      <td>
        <Link to={`/board/${boardNo}`}>
        {boardTitle}
        </Link>
      </td>
      <td>{boardWriter}</td>
      <td>{boardRegdate}</td>
      <td>{boardCnt}</td>
    </tr>
  );
};

export default BoardListItem;
