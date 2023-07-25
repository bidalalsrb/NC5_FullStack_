import React, { useEffect } from 'react';
import { Navigate, useNavigate } from 'react-router-dom';

const Mypage = () => {
  const isLogin = false;
  const navi = useNavigate();

  useEffect(() => {
    if (!isLogin) {
      navi('/login');
    }
  },[]);

  return <div>Mypage</div>;
};

export default Mypage;
