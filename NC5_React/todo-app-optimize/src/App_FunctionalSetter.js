import TodoTemplate from './components/TodoTemplate';
import TodoInsert from './components/TodoInsert';
import TodoList from './components/TodoList';
import {useCallback, useRef, useState} from 'react';

const bulkTodos = () => {
    const todoArray = [];
    for (let i = 1; i < 2500; i++) {
        const todo = {
            id: i,
            text: `할 일 ${i}`,
            checked: false
        }
        todoArray.push(todo);
    }
    return todoArray;
}

function App() {
    const [todos, setTodos] = useState(bulkTodos);
    // const [todos, setTodos] = useState([
    //     {
    //         id: 1,
    //         text: '연어초밥',
    //         checked: true,
    //     },
    //     {
    //         id: 2,
    //         text: '광어초밥',
    //         checked: true,
    //     },
    //     {
    //         id: 3,
    //         text: '새우초밥',
    //         checked: false,
    //     },
    // ]);
    // todos의 고유한 id를 생성하기 위한 useRef
    const nextId = useRef(2501);
    // todoInsert에서 새로운 todo추가 하는 메소드
    const addTodos = useCallback(
        (text) => {
            const todo = {
                id: nextId.current,
                text: text,
                checked: false,
            };
            // setter 메소드를 함수형으로 변경하고
            // 매개변수를 넣어주면 이전의 state값이 매개변수에 담긴다.
            // 특이사항이 없을 때는 setter 메소드를 함수형으로 작성한다.
            setTodos(todos => {
                console.log(todos)
                return todos.concat(todo)
            });

            nextId.current += 1;
        },
        []
    );
    //일정 지우는 메소드
    const removeTodos = useCallback((id) => {
        //filter 메소드로 id에 해당하는 todo 삭제
        setTodos(todos =>
            todos.filter((todo) => todo.id !== id)
        );
    }, []);

    // checkBox 이벤트 발생 시 checked 변경 메소드
    const changeChecked = useCallback(
        (id) => {
            setTodos(todos =>
                //     배열.map() 메소드는 새로운 배열을 리턴
                todos.map(
                    // 매개변수로는 하나씩 순회하면서 사용할 변수명 원하는 대로 지정
                    // 매개변수 t가 객체 형태이기 때문에 리턴되는 값도 객체형태
                    // 스프레드 문법은 ...변수명
                    /*
                    {...t} => {
                                            id:1,
                                            text: 'react',
                                            checked: true
                              }
                              {...t,checked: !t.checked} =>{
                                                             id:1
                                                             text : 'react'
                                                             checked : false(!true)
                                                            }
                    */
                    (t) => (t.id === id ? {...t, checked: !t.checked} : t)
                )
            )
        }, []
    )
    return (
        <TodoTemplate>
            <TodoInsert addTodos={addTodos}></TodoInsert>
            <TodoList todos={todos} remove={removeTodos} changeChecked={changeChecked}></TodoList>
        </TodoTemplate>
    );
}

export default App;
