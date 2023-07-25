import React, {useState} from 'react';
import axios from "axios";
import BootItem from "./bootItem";

function Test() {
    const [boot, setBoot] = useState([]);
    const data = async () => {
        try {
            const response = await axios.get('http://localhost:9090/api/board-list')
            console.log(response)
            setBoot(() => response.data.pageItems.content)
        } catch (e) {
            console.log(e)
        }
    }

    return (
        <>
            {/*<button onClick={data}>데이터 가져오기</button>*/}
            {/*<textarea value={JSON.stringify(boot)}></textarea>*/}

            {boot && boot.map((b) =>
                (<BootItem key={b.boardNo} boot={b}></BootItem>))}
        </>
    );
}

export default Test;