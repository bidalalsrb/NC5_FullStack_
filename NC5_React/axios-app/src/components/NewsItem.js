import React from 'react';
import styled from "styled-components";

const NewsItemBlock = styled.div`
  display: flex;
  //margin-top: 2rem;
  .thumbnail {
    margin-right: 1rem;

    img {
      display: block;
      width: 160px;
      height: 100px;
      object-fit: cover;
    }
  }

  .contents {
    h2 {
      margin: 0;
      a {
        color: black;
      }
    }

      p {
        margin: 0;
        line-height: 1.5;
        white-space: normal;
      }
  }

  //NewsItemBlock 속성 지정
  & + & {
    margin-top: 3rem;
  }
`

const NewsItem = ({article}) => {
    const
        {

            title, description, url, urlToImage
        }
            = article;
    return (
        <NewsItemBlock>
            {urlToImage &&
                (<div className='thumbnail'>
                    <a href={url} target={"_blank"}>
                        <img src={urlToImage} alt={'기사썸네일'}></img>
                    </a>
                </div>)
            }
            <div className='contents'>
                <h2>
                    <a href={url} target={"_blank"}>
                        {title}
                    </a>
                </h2>
                <p>
                    {description}
                </p>
            </div>
        </NewsItemBlock>
    );
};

export default NewsItem;
