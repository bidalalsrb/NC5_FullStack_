import React from 'react';
import { Outlet, useNavigate } from 'react-router-dom';

const page = {};
const Layot = () => {
  //useNavigate : Link 컴포넌트 없이 링크 이동
  const navi = useNavigate();

  //뒤로가기 버튼 눌렀을 때
  const goBack = () => {
    //이전 페이지 이동
    navi(-1);
  };
  const movePage = (pageName) => {
    navi(pageName);
  };
  return (
    <div>
      <header style={{ background: 'lightgray', padding: 16, fontSize: 24 }}>
        <h1>초밥</h1>
        <button type="button" onClick={goBack}>
          뒤로가기
        </button>
        {/* 매개변수가 있는 메소드를 매핑할 때는 항상 함수형으로 전달한다. */}
        <button type="button" onClick={() => movePage('/introduce')}>
          introduce
        </button>
        <button type="button" onClick={() => movePage('/profile/go')}>
          Go's profile
        </button>
        <button type="button" onClick={() => movePage('/articles')}>
          Article
        </button>
      </header>
      <main>
        <Outlet></Outlet>
      </main>
    </div>
  );
};

export default Layot;
