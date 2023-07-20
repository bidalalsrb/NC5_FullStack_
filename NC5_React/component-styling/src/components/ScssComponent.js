import React from 'react';
//scss파일 임포트
import '../scss/ScssComponent.scss';

export const ScssComponent = () => {
  return (
    <div className="ScssComponent">
      <div className="box red"></div>
      <div className="box orange"></div>
      <div className="box yellow"></div>
      <div className="box green"></div>
      <div className="box blue"></div>
      <div className="box indigo"></div>
      <div className="box violet"></div>
    </div>
  );
};

export default ScssComponent;
