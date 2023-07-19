import React, { useState } from 'react';

const EventOfComponent = ({ message, changeMessage }) => {
  const [msg, setMsg] = useState('');

  const changeMsg = (e) => {
    //e.target : 이벤트가 발생하는 DOM 객체(html 태그)
    console.log(e.target.value);
    // setMsg(e.target.value);
    changeMessage(e.target.value);
  };

  const clickBtn = () => {
    alert(message);
    // setMsg('');
    changeMessage('');
  };
  return (
    <>
      <input type="text" name="msg" onChange={changeMsg} value={message}></input>
      <button onClick={clickBtn}>확인</button>
    </>
  );
};

export default EventOfComponent;
