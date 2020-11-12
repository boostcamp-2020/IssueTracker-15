import React, { useCallback, useState } from "react";
import * as S from "./style";

import ProfileImage from "../profile-image";
import { getTimeTillNow } from "../../lib/dateParser";
import Button from "../button";
import TextArea from "../textarea";
import { closeIssue } from "../../lib/api";
import {
  addComment,
  useIssueDetailDispatch,
} from "../../contexts/issueDetailContext";
import * as api from "../../lib/api";

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
  issueId: number;
  closeIssue: () => Promise<any>;
  isIssueOpened: boolean;
}

export default function CommentBox({
  isAuthor,
  comment = null,
  textArea,
  onChangeTextArea,
  issueId,
  isIssueOpened,
}: CommentBoxPropsType) {
  const [isCommentOpen, setIsCommentOpen] = useState(comment ? false : true);

  const toggleComment = useCallback(() => {
    setIsCommentOpen(!isCommentOpen);
  }, [isCommentOpen]);

  const onClickaddComment = async () => {
    const result = await api.postComment({
      userId: 5,
      issueId: issueId,
      content: textArea,
    });
    if (result) return addComment(result, issueDetailDispatch);
    alert("커멘트 업데이트 실패!");
  };

  const issueDetailDispatch = useIssueDetailDispatch();

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
                      onClick={
                        comment
                          ? toggleComment
                          : async () => await closeIssue(issueId)
                      }
                    >
                      {comment && isIssueOpened ? "Cancle" : "Close Issue"}
                    </Button>
                  </S.ButtonWrapper>

                  <S.ButtonWrapper>
                    <Button color="green" onClick={onClickaddComment}>
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
