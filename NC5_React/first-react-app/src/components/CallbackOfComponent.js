import React, { useCallback, useMemo, useState } from 'react';

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

  //최초 렌더링 시에만 메소드 생성
  const changeNum = useCallback((e) => {
    setNum(e.target.value);
  }, []);

  //num, list 모두 값이 변경됐을 때 메소드 생성(추가 버튼 클릭 시)
  const addList = useCallback(() => {
    //불변성을 유지하기 위함
    //불변성이라는 것은 원본 데이터의 훼손을 방지하는 것이다.
    const newList = list.concat(parseInt(num));
    setList(newList);
    setNum('');
  }, [num, list]);

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
