import logo from './logo.svg';
import './App.css';
import { useEffect, useState } from 'react';

function App() {
  //state변수 생성
  //num: 상태변수
  //setNum: num을 변경하는 메소드
  const [num, setNum] = useState([]);
  const [num2, setNum2] = useState([]);

  useEffect(() => {
    axios.get({
      url:
      type
      success: (resp) =>{
        setNum2(resp);
      }
    });
  }, [num]);

  return (
    <div className="App">
      <p>{num}</p>
    </div>
  );
}

export default App;
