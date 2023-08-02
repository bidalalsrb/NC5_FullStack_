import React from 'react';
import { Link } from 'react-router-dom';

const InsertBoard = () => {
  return (
    <div>
      <div style={{display: 'flex', flexDirection: 'column', justifyContent: 'center', alignItems: "center"}}>
        <h3>새 글 등록</h3>
        <form
          id="insertForm"
        >
          <table border="1" style={{borderCollapse: 'collapse'}}>
            <tr>
              <td style={{background: 'skyblue', width: '70px'}}>제목</td>
              <td style={{textAlign: 'left'}}>
                <input type="text" />
              </td>
            </tr>
            <tr>
              <td style={{background: 'skyblue'}}>작성자</td>
              <td style={{textAlign: 'left'}}>
                <input
                  type="text"
                />
              </td>
            </tr>
            <tr>
              <td style={{background: 'skyblue', width: '70px'}}>내용</td>
              <td style={{textAlign: 'left'}}>
                <textarea name="boardContent" cols="40" rows="10"></textarea>
              </td>
            </tr>
            <tr>
              <td style={{background: 'skyblue', width: '70px'}}>파일첨부</td>
              <td>
                <div id="image_preview">
                  <input type="file" id="btnAtt" name="uploadFiles" multiple />
                  <div
                    id="attZone"
                    data-placeholder="파일을 첨부하려면 파일선택 버튼을 누르세요."
                  ></div>
                </div>
              </td>
            </tr>
            <tr>
              <td >
                <button type="button" id="btnInsert">
                  새 글 등록
                </button>
              </td>
            </tr>
          </table>
        </form>
        <hr />
        <Link href="#">글 목록</Link>
      </div>
    </div>
  );
};

export default InsertBoard;
