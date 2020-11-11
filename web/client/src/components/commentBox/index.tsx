import React, { useCallback, useState } from "react";
import * as S from "./style";

import ProfileImage from "../profile-image";
import { getTimeTillNow } from "../../lib/dateParser";
import Button from "../button";
import TextArea from "../textarea";

interface CommentBoxPropsType {
  isAuthor: boolean;
  comment?: {
    id: number;
    createAt: string;
    content: string;
    user: {
      userName: string;
      imageURL: string;
    };
  } | null;
  textArea: string;
  onChangeTextArea: (event: React.ChangeEvent<HTMLTextAreaElement>) => void;
}

export default function CommentBox({
  isAuthor,
  comment = null,
  textArea,
  onChangeTextArea,
}: CommentBoxPropsType) {
  const [isCommentOpen, setIsCommentOpen] = useState(comment ? false : true);

  const toggleComment = useCallback(() => {
    setIsCommentOpen(!isCommentOpen);
  }, [isCommentOpen]);

  return (
    <>
      <S.CommentWithProfileWrapper>
        <S.ProfilePhotoWrapper>
          <ProfileImage img={comment ? comment.user.imageURL : ""} size={40} />
        </S.ProfilePhotoWrapper>
        <S.CommentBoxWrapper>
          <S.CommentBoxTitle isAuthor={isAuthor}>
            {comment && (
              <>
                <S.TitleLeft>
                  <S.UserID>{comment.user.userName}</S.UserID>
                  <S.WriteTime>{`commented ${getTimeTillNow(
                    comment.createAt
                  )} ago`}</S.WriteTime>
                </S.TitleLeft>

                <S.TitleRight isAuthor={isAuthor}>
                  <S.UserBox>Owner</S.UserBox>
                  <S.Edit onClick={toggleComment}>Edit</S.Edit>
                </S.TitleRight>
              </>
            )}
          </S.CommentBoxTitle>
          <S.CommentBoxBody isAuthor={isAuthor}>
            {!isCommentOpen && comment && <div>{comment.content}</div>}
            {isCommentOpen && (
              <>
                <TextArea value={textArea} onChange={onChangeTextArea} />
                <S.ButtonListWrapper>
                  <S.ButtonWrapper>
                    <Button
                      color="white"
                      onClick={comment ? toggleComment : () => {}}
                    >
                      {comment ? "Cancle" : "Close Issue"}
                    </Button>
                  </S.ButtonWrapper>

                  <S.ButtonWrapper>
                    <Button color="green">
                      {comment ? "Update Comment" : "Comment"}
                    </Button>
                  </S.ButtonWrapper>
                </S.ButtonListWrapper>
              </>
            )}
          </S.CommentBoxBody>
        </S.CommentBoxWrapper>
      </S.CommentWithProfileWrapper>
    </>
  );
}
