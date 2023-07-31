import { useState, useCallback, useEffect } from 'react';
import TodoTemplate from './components/TodoTemplate';
import TodoInsert from './components/TodoInsert';
import TodoList from './components/TodoList';
import axios from 'axios';
import { useNavigate } from 'react-router-dom';

function App() {
  const [todos, setTodos] = useState([]);
  const navi = useNavigate();

  //처음 렌더링될 때 DB에 저장되어있는 리스트 호출하기
  useEffect(() => {
    const getTodoList = async () => {
      try {
        const response = await axios.get(
          'http://localhost:9090/api/todo/todo',
          {
            // params: {
            //   id: id
            // },
            headers: {
              Authorization: `Bearer ${localStorage.getItem('ACCESS_TOKEN')}`,
            },
          }
        );

        console.log(response);
        setTodos(() => response.data.items);
      } catch (e) {
        console.log(e);
        navi('/login');
      }
    };

    getTodoList();
  }, []);

  //todoInsert에서 새로운 todo추가 하는 메소드
  const addTodos = useCallback((text) => {
    const todo = {
      id: todos.length + 1,
      text: text,
      checked: false,
    };

    const insertTodo = async () => {
      try {
        const response = await axios.post(
          'http://localhost:9090/api/todo/todo',
          todo,
          {
            headers: {
              Authorization: `Bearer ${localStorage.getItem('ACCESS_TOKEN')}`,
            },
          }
        );

        setTodos(() => response.data.items);
      } catch (e) {
        console.log(e);
      }
    };

    insertTodo();
  }, []);

  //일정 지우는 메소드
  const removeTodos = useCallback((id) => {
    //filter 메소드로 id에 해당하는 todo 삭제
    setTodos((todos) => todos.filter((todo) => todo.id !== id));
  }, []);

  //checkBox 이벤트 발생 시 checked 변경 메소드
  const changeChecked = useCallback((id) => {
    setTodos((todos) =>
      //배열.map() 메소드는 새로운 배열 리턴
      todos.map(
        //매개변수로는 하나씩 순회하면서 사용할 변수명 원하는 대로 지정
        //매개변수 t가 객체 형태이기 때문에 리턴되는 값도 객체형태
        //스프레드 문법은 ...변수명
        /*{...t} => {
                      id: 1,
                      text: 'react',
                      checked: true
                    }
          {...t, checked: !t.checked} => {
                                           id: 1,
                                           text: 'react',
                                           checked: false(!true)
                                         }
          {...t, checked: !t.checked, aaa: 1} => {
                                                  id: 1,
                                                  text: 'react',
                                                  checked: false(!true),
                                                  aaa: 1
                                                }
        */
        (t) => (t.id === id ? { ...t, checked: !t.checked } : t)
      )
    );
  }, []);

  return (
    <TodoTemplate>
      <TodoInsert addTodos={addTodos}></TodoInsert>
      {/* 자식 컴포넌트에서 이벤트가 발생했을 때 부모 컴포넌트도 리렌더링 하려면
          부모의 스테이트를 변경해야한다.
          부모의 스테이트를 자식에서 변경하는 방법은 부모 컴포넌트에 스테이트의 setter 메소드를 호출하는 메소드를 정의한뒤 자식 컴포넌트에 props로 해당 메소드를 전달해서 자식컴포넌트에서 이벤트가 발생했을 때 props로 받아온 메소드를 호출 */}
      <TodoList
        todos={todos}
        removeTodos={removeTodos}
        changeChecked={changeChecked}
      ></TodoList>
    </TodoTemplate>
  );
}

export default App;
