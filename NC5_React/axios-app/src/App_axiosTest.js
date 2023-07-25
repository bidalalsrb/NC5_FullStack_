import React, {useState} from 'react';
import axios from "axios";
// APIT KEY  d1ee34e1312647549781131e1630b4cf
function App() {

    const [data, setDate] = useState(null)
    // const loadData = () => {
    //     //axios로 api 데이터 받아오기
    //     axios.get('https://jsonplaceholder.typicode.com/todos/1').then(Response => {
    //         console.log(Response);
    //         setDate(Response.data);
    //     })
    const loadData = async () => {
        try {
            const Response = await axios.get('https://newsapi.org/v2/top-headlines?country=kr&apiKey=d1ee34e1312647549781131e1630b4cf')
            console.log(Response.data.articles[0].title)
            setDate(Response.data)
        } catch (error) {
            console.log(error)
        }
    }
    return (
        <div className="App">
            <div>
                <button onClick={loadData}>데이터 불러오기</button>
            </div>
            {data && <textarea rows={7} value={JSON.stringify(data)} readOnly={true}></textarea>}
        </div>
    );
}

export default App;
