import React from 'react';
import styled from 'styled-components';

//styled-component 생성
//하나의 컴포넌트처럼 사용
const Box1 = styled.div`
  width: 32px;
  height: 32px;
  background: red;
`;
const Box2 = styled.div`
  width: 64px;
  height: 64px;
  background: orange;
`;
const Box3 = styled.div`
  width: 70px;
  height: 70px;
  background: yellow;
`;
const Box4 = styled.div`
  width: 80px;
  height: 80px;
  background: green;
`;
const Box5 = styled.div`
  width: 90px;
  height: 90px;
  background: blue;
`;
const Box6 = styled.div`
  width: 100px;
  height: 100px;
  background: indigo;
`;
const Box7 = styled.div`
  width: 110px;
  height: 110px;
  background: violet;
`;
const Con = styled.div`
  display: flex;

`;
const StyleComponent = () => {
  return (
    <>
      <Con>
        <Box1></Box1>
        <Box2></Box2>
        <Box3></Box3>
        <Box4></Box4>
        <Box5></Box5>
        <Box6></Box6>
        <Box7></Box7>
      </Con>
    </>
  );
};

export default StyleComponent;
