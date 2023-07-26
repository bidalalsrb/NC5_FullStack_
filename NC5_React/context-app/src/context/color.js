//createContext로 생성한 context를 export해야한다
import {createContext, useState} from "react";

//context 생성
//Provider, Consumer를 소유
const ColorContext = createContext({
    state: {color: 'black', subColor: 'red'},
    actions: {
        setColor: () => {
        },
        setSubColor: () => {
        }
    }
})

// provider를 리턴하는 컴포넌트
const ColorProvider = ({children}) => {
    const [color, setColor] = useState('black')
    const [subColor, setSubColor] = useState('red');
    const value = {
        state: {color, subColor},
        actions: {setColor, setSubColor}
    }
    return <ColorContext.Provider value={value}>{children}</ColorContext.Provider>
}

//Consumer 리턴하는 컴포넌트
// colorConsumer == ColorContext.Consumer
const {Consumer: ColorConsumer} = ColorContext;

export {ColorProvider, ColorConsumer};
