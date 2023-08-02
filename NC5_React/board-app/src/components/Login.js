import React from 'react';
import '../css/Login.css';
const Login = () => {
  return (
    <div>
      <div className="form-wrapper">
        <form id="loginForm">
          <h3>로그인</h3>
          <div className="label-wrapper">
            <label htmlFor="userId">아이디</label>
          </div>
          <input type="text" id="userId" name="userId" required />
          <div className="label-wrapper">
            <label htmlFor="userPw">비밀번호</label>
          </div>
          <input type="password" id="userPw" name="userPw" required />
          <div style={{ display: 'block', margin: '20px auto' }}>
            <button type="submit" id="btnLogin">
              로그인
            </button>
          </div>
        </form>
      </div>
    </div>
  );
};

export default Login;
