import React from 'react';
import ColorContext, {ColorConsumer} from "../context/color";

const ColorBox = () => {
    return (
        <ColorConsumer>
            {({state}) =>
                <div>
                    <div style={{width: '100px', height: '100px', background: state.color}}></div>
                    <div style={{width: '50px', height: '50px', background: state.subColor}}></div>
                </div>
            }
        </ColorConsumer>
    );
};

export default ColorBox;
