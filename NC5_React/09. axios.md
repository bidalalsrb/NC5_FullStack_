# 1. axios

## 1. axios란?

### 1. axios는 웹 브라우저에서 HTTP 요청을 보내고 응답을 받을 수 있는 HTTP 클라이언트 라이브러리

### 2. axios는 promise 기반이며 ajax의 상위 호환 버전이라고 생각하면 된다.

### 3. axios 설치 : npm install axios

## 2. axios 사용법

### 1. 기본적인 axios 사용법

```
axiso({
    type: 'GET'/'POST'/'PUT'/'DELETE' ....,
    url: 요청 url 주소,
    responseType : 'json'})
    .then(reposse =>{
    처리할 내용
    )}.catch(error => {
    에러 발생 시 처리할 내용
    });
```

### 2. axios의 단축 사용

- 요청 방식에 따른 단축 메소드를 사용할 수 있다.
- get,post,put,delete 등의 메소드를 사용하요 axios 단축 사용한다.

```
//get방식
//get방식은 request body를 만들 수가 없어서 데이터전송은 params로 진행
//params는 config 객체에 포함된다.
axios.get(요청 url 주소, config 객체)
    .then(response =>{
    처리할 내용
    })
    .catch(error =>{
    에러 발생 시 처리할 내용
    });
    
//post방식
axios.post(요청 url 주소, config 객체)
    .then(response =>{
    처리할 내용
    })
    .catch(error =>{
    에러 발생 시 처리할 내용
    });
    
//put방식
axios.put(요청 url 주소, config 객체)
    .then(response =>{
    처리할 내용
    })
    .catch(error =>{
    에러 발생 시 처리할 내용
    });
    
//delete 방식
axios.delete(요청 url 주소, config 객체)
    .then(response =>{
    처리할 내용
    })
    .catch(error =>{
    에러 발생 시 처리할 내용
    });
```

- 단축 메소드들은 매개변수로 객체를 받지 않기 때문에 키를 지정할 필요가 없다. 대신 매개변수의 순서를 정확히 지켜줘야 한다.
- 모든 단축 메소드에서 url을 제외한 매개변수는 모두 생략가능하다.

# 2. Promise

## 1. Promise란?

### 1. Promise는 javascript에서 비동기 처리를 담당하는 객체

### 2. .then(), .catch(), .finally() 메소드를 통해서 비동기 작업을 처리한다.

### 3. axios가 promise 기반의 비동기 통신이라 통신이 성공했을 때는 then() 메소드를 에러가 발생했을 때는 catch() 메소드를 에러의 발생

### 3. 유무와 상관없이 통신이 끝났을 때는 finally()를 통해서 비동기 통신에 대한 처리를 할 수 있다.

# 3. async/await

## 1. async/await

### 1. async/awaut를 이용하면 promise를 좀 더 가독성있고 편하게 구현할 수 있다.

### 2. 메소드 앞에 async를 붙여주면 해당 메소드는 항상 Promise 객체를 리턴하게 된다.

### 3. await는 항상 메소드 안에서만 사용한다. Promise 객체의 결과값을 받을 때까지 함수를 중지시키는 역할을 한다.

### 4. async/await 사용 시 예외처리는 메소드 안에 try~catch 블록을 열어서 처리한다.

### 5. 사용법

```
const 메소드명 = async () =>{
//예외처리를 위한 try~catch 블록
    try{
        //Promise 객체의 결과를 받을 때까지 메소드의 실행을 중지함
        const response = await axios.get();
        
        //받은 데이터로 처리할 내용 작성
        } catch(error){
       //에러 발생 시 처리할 내용 작성
        }

async function 메소드명(){
    try{
        //Promise 객체의 결과를 받을 때까지 메소드의 실행을 중지함
        const response = await axios.get();
        
        //받은 데이터로 처리할 내용 작성
        } catch(error){
       //에러 발생 시 처리할 내용 작성
        }
}
```
# 4. news-app 구현하기
## 1. APIs
### 1. 전체 뉴스 받는 API
- GET https://newsapi.org/v2/top-headlines?country=kr&apiKey=발급받은 키값
### 2. 특정 카테고리의 뉴스를 받는 API
- GET https://newsapi.org/v2/top-headlines?country=kr&category=business&apiKey=발급받은 키값
### 3. 컴포넌트 구성
- NewItem : 기사 하나에 대한 내용을 표시해줄 컴포넌트
- NewsList : 기사 목록을 표출할 컴포넌트. 자식 컴포넌트로 NewItem를 사용
- Categories : 기사의 카테고리의 이동을 담당할 컴포넌트 
- NewsPage : Router 기능을 구현할 컴포넌트

