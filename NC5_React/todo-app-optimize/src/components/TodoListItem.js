import React from 'react';
import {
    MdCheckBoxOutlineBlank,
    MdCheckBox,
    MdRemoveCircleOutline,
} from 'react-icons/md';
import '../scss/TodoListItem.scss';
import cn from 'classnames';

const TodoListitem = ({todo, remove,changeChecked}) => {
    // 비구조 할당으로 props의 내용 분리

    const {id, text, checked} = todo;
    const handleRemove = () => {
        if (window.confirm('삭제할꺼야?')) {
            remove(id);
        }
    };

    return (
        <div className="TodoListItem">
            {/* clssnames 라이브러리를 이용한 조건부 클래스 스타일 적용 */}
            <div className={cn('checkbox', {checked})} onClick={()=>changeChecked(id)}  >
                {checked ? (
                    <MdCheckBox></MdCheckBox>
                ) : (
                    <MdCheckBoxOutlineBlank></MdCheckBoxOutlineBlank>
                )}
                <div className="text">{text}</div>
            </div>

            <div className="remove" onClick={handleRemove}>
                <MdRemoveCircleOutline></MdRemoveCircleOutline>
            </div>
        </div>
    );
};

export default React.memo(TodoListitem);
