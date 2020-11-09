import React from 'react';
import * as S from './style';

import ProfileImage from '../profile-image'
import { getTimeTillNow } from '../../lib/dateParser';

interface CommentBoxPropsType {
  isAuthor: boolean;
  comment: {
    id: number;
    createAt: string;
    content: string;
    user: {
      userName: string;
      imageURL: string;
    }
  }
}


export default function CommentBox({ isAuthor, comment }: CommentBoxPropsType) {

  return (
    <>
    <S.CommentWithProfileWrapper>
      <S.ProfilePhotoWrapper>
        <ProfileImage img={comment.user.imageURL} size={40}/>
      </S.ProfilePhotoWrapper>
      <S.CommentBoxWrapper>
        <S.CommentBoxTitle isAuthor={isAuthor}>
          <S.TitleLeft>
            <S.UserID>{comment.user.userName}</S.UserID>
            <S.WriteTime>{`commented ${getTimeTillNow(comment.createAt)} ago`}</S.WriteTime>
          </S.TitleLeft>

          <S.TitleRight isAuthor={isAuthor}>
            <S.UserBox>Owner</S.UserBox>
            <S.Edit>Edit</S.Edit>
          </S.TitleRight>
        </S.CommentBoxTitle>
        <S.CommentBoxBody isAuthor={isAuthor}>
          <div>
            {comment.content}
          </div>
        </S.CommentBoxBody>
      </S.CommentBoxWrapper>
    </S.CommentWithProfileWrapper>
    </>
  );
}
