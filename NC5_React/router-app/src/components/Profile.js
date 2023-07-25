import React from 'react';
import { useParams } from 'react-router-dom';

const profiles = {
    go: {
        name: "고기천",
        job: "강사" 
    },
    hong: {
        name: "홍길동",
        job: "의적"
    }
};

const Profile = () => {
    //url 파라미터 받아주기
    const params = useParams();

    const selectedProfile = profiles[params.firstName];
  return (
    <div>
        <h1>Profile</h1>
        {selectedProfile ? (
            <div>
                <h2>{selectedProfile.name}</h2>
                <p>{selectedProfile.job}</p>
            </div>
            ) : (
                <p>notExist Profile</p>
            )
        }
    </div>
  );
};

export default Profile;