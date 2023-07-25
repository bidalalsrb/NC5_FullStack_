import React from 'react';
import styled, {css} from 'styled-components';
import {NavLink} from "react-router-dom";

const categories = [
    {
        name: 'all',
        text: '전체보기',
    },
    {
        name: 'business',
        text: '비즈니스',
    },
    {
        name: 'entertainment',
        text: '엔터',
    },
    {
        name: 'health',
        text: '건강',
    },
    {
        name: 'science',
        text: '과학',
    },
    {
        name: 'sports',
        text: '스포츠',
    },
    {
        name: 'technology',
        text: '기술',
    },
];

const CategoriesBlock = styled.div`
  display: flex;
  padding: 1rem;
  width: 768px;
  margin: 0 auto;
  @media screen and (max-width: 768px) {
    width: 100%;
    overflow-x: auto;
  }
`;

const Category = styled(NavLink)`
  font-size: 1.125rem;
  cursor: pointer;
  white-space: pre;
  text-decoration: none;
  color: inherit;
  padding: 0.25rem;

  &:hover {
    color: #495057;
  }

  & + & {
    margin-left: 1rem;
  }

  ${(props) =>
          props.active &&
          css`
            font-weight: 600;
            border: 2px solid #22b8cf;
            color: #22b8cf;

            &:hover {
              color: #3bc9db;
            }
          `}
`;

function Categories({category, changeCategory}) {
    return (
        <CategoriesBlock>
            {categories &&
                categories.map((cate) => (
                    <Category
                        key={cate.name}
                        onClick={() => changeCategory(cate.name)}
                        active={category === cate.name}
                    >
                        {cate.text}
                    </Category>
                ))}
        </CategoriesBlock>
    );
}

export default Categories;
