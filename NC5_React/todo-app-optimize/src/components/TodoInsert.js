import React, {useState, useCallback} from 'react';

//+ 아이콘 임포트
import {MdAdd} from 'react-icons/md';
import '../scss/TodoInsert.scss';



const TodoInsert = ({addTodos}) => {
    const [text, setText] = useState('');
    const textChange = useCallback((e) => {
        setText(e.target.value);
    }, []);
    const handleSubmit = useCallback((e) => {
        e.preventDefault();
        addTodos(text);
        setText('')
    }, [addTodos, text])


    return (
        <form className="TodoInsert" onSubmit={handleSubmit}>
            <input
                placeholder="초밥을 입력하세요"
                value={text}
                onChange={textChange}
            ></input>
            <button type="submit">
                <MdAdd></MdAdd>
            </button>
        </form>
    );

};

export default TodoInsert;
