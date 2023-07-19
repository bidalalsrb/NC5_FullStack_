import logo from './logo.svg';
import './App.css';
import { Fragment, useEffect, useState } from 'react';

function App() {
  let str1 = "hello";
  let str2 = "world";

  return (
    <>
      <div className='react'>
        {str1}
      </div>
      <div style={{backgroundColor: 'red'}}>
        {str2}
      </div>
      {str1 === "hello" ? <div>1</div> : <div>2</div>}
      //주석으로 읽히지 않음
      /**이것도 마찬가지 */
      {/*주석은 이형태로만 */}
    </>
  );
}

export default App;
