import React from 'react';
import * as S from './style';

interface CommentBoxPropsType {
  isAuthor: boolean;
}

export default function CommentBox({ isAuthor }: CommentBoxPropsType) {
  return (
    <>
      <S.CommentBoxWrapper>
        <S.CommentBoxTitle isAuthor={isAuthor}>
          <S.TitleLeft>
            <S.UserID>moaikang</S.UserID>
            <S.WriteTime>commented 3 days ago</S.WriteTime>
          </S.TitleLeft>

          <S.TitleRight isAuthor={isAuthor}>
            <S.UserBox>Owner</S.UserBox>
            <S.Edit>Edit</S.Edit>
          </S.TitleRight>
        </S.CommentBoxTitle>
        <S.CommentBoxBody isAuthor={isAuthor}>
          <div>
            딱대시는것이 <br />
            좋을거 같아요
          </div>
        </S.CommentBoxBody>
      </S.CommentBoxWrapper>
    </>
  );
}
