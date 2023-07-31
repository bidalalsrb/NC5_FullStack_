import React, {useCallback} from 'react';
import {
    Button,
    TextField,
    Link,
    Grid,
    Container,
    Typography
} from "@mui/material";
import axios from 'axios';
import { useNavigate } from 'react-router-dom';

const Login = () => {
    const navi = useNavigate();

    const onSubmit = useCallback((e) => {
        e.preventDefault();

        const data = new FormData(e.target);
        const username = data.get("username");
        const password = data.get("password");

        login(username, password);
    }, []);

    const login = useCallback(async (username, password) => {
        try {
            const response = await axios.post('http://localhost:9090/api/member/login', {username: username, password: password});

            if(response.data && response.data.item.token !== null && response.data.item.token !== "") {
                localStorage.setItem("ACCESS_TOKEN", response.data.item.token);
                navi("/");
            }

            console.log(response);
        } catch(e) {
            alert(e.response.data.errorMessage);
        }
    }, []);

  return (
    <Container component="main" maxWidth="xs" style={{marginTop: "8%"}}>
        <form onSubmit={onSubmit}>
            <Grid container spacing={2}>
                <Grid item xs={12}>
                    <Typography component="h1" variant="h5">
                        로그인
                    </Typography>
                </Grid>
                <Grid item xs={12}>
                    <TextField
                        name="username"
                        variant="outlined"
                        required
                        fullWidth
                        id='username'
                        label="아이디"
                        autoFocus
                    ></TextField>
                </Grid>
                <Grid item xs={12}>
                    <TextField
                        name="password"
                        variant="outlined"
                        required
                        fullWidth
                        id='password'
                        label="비밀번호"
                        type="password"
                    ></TextField>
                </Grid>
                <Grid item xs={12}>
                    <Button type='submit' fullWidth variant='contained' color='primary'>로그인</Button>
                </Grid>
            </Grid>
            <Grid container justifyContent="flex-end">
                <Grid item>
                    <Link href='/join' variant='body2'>
                        계정이 없으시면 여기서 회원가입하세요.
                    </Link>
                </Grid>
            </Grid>
        </form>
    </Container>
  );
};

export default Login;