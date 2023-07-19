import logo from './logo.svg';
import './App.css';
import { Fragment, useEffect, useState } from 'react';
//내보낸 컴포넌트를 import하여서 사용한다.
//태그처럼 사용
import EffectOfComponent from './components/EffectOfComponent';
import ReducerOfComponent from './components/ReducerOfComponent';
function App() {
  return (
    <>
      <EffectOfComponent> </EffectOfComponent>
      <ReducerOfComponent></ReducerOfComponent>
    </>
  );
}

export default App;
