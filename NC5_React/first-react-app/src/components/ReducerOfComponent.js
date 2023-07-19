import React, { useReducer } from 'react';

//reducer로 동작할 메소드
function reducer(state, action) {
  switch (action.type) {
    case 'INCREASE':
      return {
        value1: state.value1 + 1,
        value2: (state.value1 + 1) * 2,
      };
    case 'DECREASE':
      return {
        value1: state.value1 - 1,
        value2: (state.value1 - 1) * 2,
      };
    default:
      return state;
  }
}

const ReducerOfComponent = () => {
  const [state, dispatch] = useReducer(reducer, { value1: 0, value2: 0 });

  return (
    <>
      <div>{state.value1}</div>
      <div>{state.value2}</div>
      {/* {dispatch 메소드로 action을 발생시켜서 reducer 메소드가 호출되도록 한다.} */}
      <button onClick={() => dispatch({ type: 'INCREASE' })}>+1</button>
      <button onClick={() => dispatch({ type: 'DECREASE' })}>-1</button>
    </>
  );
};

export default ReducerOfComponent;
