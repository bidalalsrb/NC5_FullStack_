import React, { useCallback, useEffect, useState } from 'react';
import '../css/Join.css';
import { TextFiled } from '@mui/material';
import axios from 'axios';

const Join = () => {
  const [userId, setUserId] = useState('');

  const changeUserId = useCallback((e) => {
    setUserId(() => e.target.value);
  }, []);

  const idCheck = useCallback((e) => {
    const userIdInput = document.getElementById('userId');
    const idCheckAxios = async () => {
      let checkId = false;
      try {
        const response = await axios.post(
          'http://localhost:9090/user/id-check',
          { userId: userId }
        );
        console.log(response);
        if (response.data && response.data.item.idChecking === 'idOk') {
          alert('사용가능한 아이디입니다');
          checkId = true;
          e.target.disabled = true;
        } else {
          alert('중복된 아이디입니다');
          checkId = false;
          userIdInput.focus();
        }
      } catch (error) {
        console.groupEnd(error)
      }
    };
    idCheckAxios();
  });

  return (
    <div className="form-wrapper">
      <form id="modifyForm">
        <input type="hidden" id="joinMsg" variant="standard"></input>
        <h3>회원가입</h3>
        <div className="label-wrapper">
          <label htmlFor="userId">아이디</label>
        </div>
        <div>
          <input
            type="text"
            id="userId"
            name="userId"
            required
            style={{ width: 'auto' }}
          />
          <button
            type="button"
            id="btnIdCheck"
            style={{ width: '70px' }}
            onClick={idCheck}
          >
            중복체크
          </button>
        </div>
        <div className="label-wrapper">
          <label htmlFor="userPw">비밀번호</label>
        </div>
        <input type="password" id="userPw" name="userPw" required />
        <p id="pwValidation" style={{ color: 'red', fontSize: '0.8rem' }}>
          비밀번호는 영문자, 숫자, 특수문자 조합의 9자리 이상으로 설정해주세요.
        </p>
        <div className="label-wrapper">
          <label htmlFor="userPwCheck">비밀번호 확인</label>
        </div>
        <input type="password" id="userPwCheck" name="userPwCheck" required />
        <p id="pwCheckResult" style={{ fontSize: '0.8rem' }}></p>
        <div className="label-wrapper">
          <label htmlFor="userName">이름</label>
        </div>
        <input type="text" id="userName" name="userName" required />
        <div className="label-wrapper">
          <label htmlFor="userEmail">이메일</label>
        </div>
        <input type="email" id="userEmail" name="userEmail" required />
        <div className="label-wrapper">
          <label htmlFor="userTel">전화번호</label>
        </div>
        <input
          type="text"
          id="userTel"
          name="userTel"
          placeholder="숫자만 입력하세요."
        />
        <div style={{ display: 'block', margin: ' 20px auto' }}>
          <button type="submit">회원가입</button>
        </div>
      </form>
    </div>
  );
};

export default Join;
