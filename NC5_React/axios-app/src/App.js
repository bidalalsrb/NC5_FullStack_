import React from 'react';
import {Routes, Route} from "react-router-dom";
import NewsPage from "./pages/NewsPage";


// APIT KEY  d1ee34e1312647549781131e1630b4cf
function App() {


    return (
            <Routes>
                <Route path="/" element={<NewsPage></NewsPage>}></Route>
                <Route path="/:category" element={<NewsPage></NewsPage>}></Route>
            </Routes>
    );
}

export default App;
