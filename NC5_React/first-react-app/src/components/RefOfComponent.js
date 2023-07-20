import React, { useRef } from 'react';

const RefOfComponent = () => {
  const idRef = useRef();
  const pwRef = useRef();

  const fncClick = () => {
    console.log(idRef.current);
    //선택자 없이 DOM에 접근
    if(idRef.current.value === ""){
      alert("아이디를 입력하세요");
      return;

    }
    if(pwRef.current.value === ""){
      alert("비밀번호를 입력하세요");
      return;

    }

  };
  return (
    <div>
      <label>아이디
        <input ref={idRef} type="text"></input>
      </label>
      <label>비밀번호
        <input ref={pwRef} type="text"></input>
      </label>
      <button onClick={fncClick}>클릭</button>
    </div>
  );
};

export default RefOfComponent;
