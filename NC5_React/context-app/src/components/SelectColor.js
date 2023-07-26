import React from 'react';
import {ColorConsumer} from "../context/color";

const colorArr = ['black', 'red', 'green', 'blue', 'yellow', 'orange', 'gray', 'violet']
const SelectColor = () => {
    return (
        <div>
            <h1>색상 선택</h1>
            <ColorConsumer>
                {({actions}) => (
                    <div style={{display: 'flex'}}>{colorArr && colorArr.map((color) => (
                        <div key={color} style={{width: '25px', height: '25px', background: color, cursor: "pointer"}}
                             onClick={() => actions.setColor(color)}
                             onContextMenu={(e) => {
                                e.preventDefault();
                                actions.setSubColor(color);
                             }}>

                        </div>
                    ))}
                    </div>)
                }
            </ColorConsumer>
            <hr/>
        </div>
    );
};

export default SelectColor;
