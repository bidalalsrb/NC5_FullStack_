import React from 'react';
//css모듈 임포트
import styles from '../cssmodule/CssModule.module.css';
const CssModule = () => {
  return (
    <div>
      <div className={`${styles.wrapper} ${styles.inverted}  `}>
        cssmodule
        {/* global 클래스 사용 */}
        <span className='text'>SCSS</span>
      </div>
    </div>
  );
};
export default CssModule;
