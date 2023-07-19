import React, { useEffect, useState } from 'react';

const EffectOfComponent = () => {
  const [num1, setNum1] = useState(0);
  const [num2, setNum2] = useState(0);

  //초기 렌더링 시 실행될 작업
  useEffect(() => {
    alert('최초 렌더링 실행');
  }, []);

  //num1 state 값 변경 시 실행될 작업
  useEffect(() => {
    alert(`${num1}`);
    setNum2(num1 * 2);
  }, [num1]);

  //num1 값이 변경되기 직전에 실행될 작업
  //cleanup 메소드를 리턴해주면 된다.
  // useEffect(() => {
  //   //num1이 변경되기 직전에 return 문의 메소드가 실행된다.
  //   return () => {
  //     alert(`${num1}`);
  //   };
  // }, [num1]);

  return (
    <>
      <div>{num1}</div>
      <div>{num2}</div>
      <button onClick={() => setNum1(num1 + 1)}>+1</button>
    </>
  );
};

export default EffectOfComponent;
