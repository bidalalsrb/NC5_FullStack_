import React from 'react';
import '../scss/TodoTemplate.scss';

const TodoTemplate = ({ children }) => {
  return (
    <div className="TodoTemplate">
      <div className="app-title">오늘의 초밥</div>
      <div className='content'>{children}</div>
    </div>
  );
};

export default TodoTemplate;
