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
  const addTodos = useCallback(
    (text) => {
      let id = 0;
      todos.forEach( t =>{
        if(t.id > id){
          id = t.id
        }
      })

      const todo = {
        id: id + 1,
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
    },
    [todos]
  );

  //일정 지우는 메소드
  const removeTodos = useCallback((id) => {
    //filter 메소드로 id에 해당하는 todo 삭제
    const deleteTodo = async () => {
      try {
        const response = await axios.delete(
          'http://localhost:9090/api/todo/todo',
          {
            params: {
              id: id,
            },
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
    deleteTodo();
  }, []);

  //checkBox 이벤트 발생 시 checked 변경 메소드
  const changeChecked = useCallback((todo) => {
    const updateTodo = async () => {
      try {
        const response = await axios.put(
          'http://localhost:9090/api/todo/todo',
          {
            ...todo,
            checked: !todo.checked,
          },
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
    updateTodo();
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
