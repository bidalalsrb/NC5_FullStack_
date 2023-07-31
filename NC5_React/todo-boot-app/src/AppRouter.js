import React from 'react';
import {Routes, Route} from 'react-router-dom';
import App from './App';
import Join from './components/Join';
import Login from './components/Login';

const AppRouter = () => {
  return (
    <Routes>
        <Route path='/' element={<App></App>}></Route>
        <Route path="/join" element={<Join></Join>}></Route>
        <Route path='/login' element={<Login></Login>}></Route>
    </Routes>
  );
};

export default AppRouter;