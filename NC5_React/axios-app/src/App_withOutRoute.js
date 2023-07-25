import React, {useCallback, useState} from 'react';
import NewsList from "./components/NewsList";
import Categoris from "./components/Categoris";

// APIT KEY  d1ee34e1312647549781131e1630b4cf
function App() {
    const [category, setCategory] = useState('all');

    const changeCategory = useCallback(
        (category) => {
            setCategory(() => category);
        },
        []
    );


    return (
        <div className="App">
            <>
                <Categoris category={category} changeCategory={changeCategory}></Categoris>
                <NewsList category={category}></NewsList>
            </>
        </div>
    );
}

export default App;
