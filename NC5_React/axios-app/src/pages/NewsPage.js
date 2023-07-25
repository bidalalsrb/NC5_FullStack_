import React from 'react';
import {useParams} from "react-router-dom";
import Categories from "../components/Categoris";
import NewsList from "../components/NewsList";

function NewsPage() {

    const params = useParams();

    const category = params.category || 'all';

    return (
        <>
            <Categories></Categories>
            <NewsList category={category}></NewsList>
        </>
    );
}

export default NewsPage;