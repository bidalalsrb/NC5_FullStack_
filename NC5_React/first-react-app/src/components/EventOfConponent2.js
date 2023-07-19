import React, { useState } from 'react';

const EventOfConponent2 = () => {
  const [num, setNum] = useState(0);

  //매개변수가 있는 메소드 이벤트 매핑
  const minusNum = (number) => {
    setNum(number);
  };

  return (
    <>
      <div>{num}</div>
      <button
        onClick={() => {
          setNum(num + 1);
        }}
      >
        +1
      </button>
      <button
        onClick={() => {
          minusNum(num - 1);
        }}
      >
        -1
      </button>
    </>
  );
};

export default EventOfConponent2;
