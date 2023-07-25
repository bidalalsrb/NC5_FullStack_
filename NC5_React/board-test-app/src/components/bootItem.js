import React from 'react';

function BootItem({boot}) {
    return (
        <>
            <p>boardNo : {boot.boardNo}</p>
            <p>boardTitle : {boot.boardTitle}</p>
            <p>boardContent : {boot.boardContent}</p>
            <p>boardWriter : {boot.boardWriter}</p>
            <p>boardReg : {boot.boardRegdate}</p>
            <p>boardCnt : {boot.boardCnt}</p>
            <br/>
        </>
    );
}

export default BootItem;