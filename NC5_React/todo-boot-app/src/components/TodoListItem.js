import React from 'react';
import {
    MdCheckBoxOutlineBlank,
    MdCheckBox,
    MdRemoveCircleOutline
} from 'react-icons/md';
import '../scss/TodoListItem.scss';
import cn from 'classnames';

const TodoListItem = ({todo, removeTodos, changeChecked}) => {
    //비구조 할당으로 props의 내용 분리
    const {id, text, checked} = todo;

  return (
    <div className='TodoListItem'>
        {/* classnames 라이브러리를 이용한 조건부 스타일 적용 */}
        {/* checked인 클래스를 조건부로 추가하기 위한 코드 */}
        <div className={cn('checkbox', {checked})} onClick={() => changeChecked(id)}>
            {
                checked ? 
                <MdCheckBox></MdCheckBox> : 
                <MdCheckBoxOutlineBlank></MdCheckBoxOutlineBlank>
            }
            <div className='text'>{text}</div>
        </div>
        <div className='remove' onClick={() => removeTodos(id)}>
            <MdRemoveCircleOutline></MdRemoveCircleOutline>
        </div>
    </div>
  );
};

export default React.memo(TodoListItem);