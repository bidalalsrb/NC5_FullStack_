import TodoTemplate from './components/TodoTemplate';
import TodoInsert from './components/TodoInsert';
import TodoList from './components/TodoList';
import {useCallback, useReducer, useRef, useState} from 'react';

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

// 리듀서 메소드의 첫번째 매개변수로는 state 값이 온다.
// 리듀서 메소드의 두번째 매개변수로는 dispatch 메소드의 매개변수가 온다.
function reducer(todos, action) {
    switch (action.type) {
        // {type : 'INSERT', todo : { id:1, text: 'react', checked:true/false}
        case 'INSERT':
            return todos.concat(action.todo);
        // {type : 'REMOVE', id:2}
        case 'REMOVE':
            return todos.filter(todo => todo.id !== action.id);
        //{type : 'TOGGLE, id:3}
        case 'TOGGLE':
            return todos.map(todo => todo.id === action.id
                ? {
                    ...todo, checked: !todo.checked
                } : todo)

    }
}

function App() {
    // useReducer: state를 생성하는 hook, setter메소드 대신 dispatch라는 메소드를 갖는다. 첫 번째 매개변수로 리듀서 메소드를 매핑.
    // 리듀서 메소드는 상황에 따라서 state 값을 다르게 변경하도록 구현
    // dispatch 메소드가 action을 발생시키면서 자동적으로 지정된 리듀서 메소드를 호출한다.

    const [todos, dispatch] = useReducer(reducer, undefined, bulkTodos);
    // const [todos, setTodos] = useState(bulkTodos);
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
            // dispatch로 액션을 실행한다
            dispatch({type: 'INSERT', todo: todo})
            nextId.current += 1;
        },
        []
    );
    //일정 지우는 메소드
    const removeTodos = useCallback((id) => {
        //filter 메소드로 id에 해당하는 todo 삭제
        dispatch({type: 'REMOVE', id: id})
    }, []);

    // checkBox 이벤트 발생 시 checked 변경 메소드
    const changeChecked = useCallback(
        (id) => {
            dispatch({type: 'TOGGLE', id: id})
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
