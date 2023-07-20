import React, { useMemo, useState } from 'react';

const getAvg = (numList) => {
  if (numList.length === 0) {
    return 0;
  }

  let sum = 0;

  numList.forEach((num) => {
    sum += num;
  });

  return sum / numList.length;
};

const MemoOfComponent = () => {
  const [list, setList] = useState([]);
  const [num, setNum] = useState('');

  //렌더링될 때마다 메소드가 재생성 되는 상태
  const changeNum = (e) => {
    setNum(e.target.value);
  };

  //렌더링될 때마다 메소드가 재생성 되는 상태
  const addList = () => {
    //불변성을 유지하기 위함
    //불변성이라는 것은 원본 데이터의 훼손을 방지하는 것이다.
    const newList = list.concat(parseInt(num));
    setList(newList);
    setNum('');
  };

  //useMemo를 통한 연산 최적화
  //list 값이 변경됐을 때만 연산이 일어나도록
  const average = useMemo(() => getAvg(list), [list]);

  return (
    <div>
      <input value={num} onChange={changeNum}></input>
      <button onClick={addList}>추가</button>
      {/* {list에 있는 데이터를 표출할 때는 map 메소드를 주로 사용한다} */}
      {/* {list가 비어있을 때를 방지하기 위해서 단축평가를 사용한다} */}
      <ul>
        {list &&
          list.map((number, index) => {
            return <li key={index}>{number}</li>;
          })}
      </ul>{' '}
      <div>{average}</div>
    </div>
  );
};

export default MemoOfComponent;
