import React, { useCallback, useState } from "react";

import * as S from "./style";
import { getTimeTillNow } from "../../lib/dateParser";
import Button from "../button";

interface IssueProps {
  title: string;
  id: number;
  author: {
    userName: string;
  };
  createAt: string;
  commentLength: number;
}
export default function IssueHeader({
  title,
  id,
  author,
  createAt,
  commentLength,
}: IssueProps) {
  const [isEditBoxOpen, setIsEditBoxOpen] = useState(false);

  const toggleEditBox = useCallback(() => {
    setIsEditBoxOpen(!isEditBoxOpen);
  }, [isEditBoxOpen]);

  return (
    <S.IssueHeaderWrapper>
      <S.IssueTitleNumberButtonWrapper>
        <S.IssueTitleNumberWrapper>
          {!isEditBoxOpen && (
            <>
              <S.IssueTitle>{title}</S.IssueTitle>
              <S.IssueNumber>#{id}</S.IssueNumber>
            </>
          )}
          {isEditBoxOpen && <S.EditBox autoFocus={true} />}
        </S.IssueTitleNumberWrapper>

        <S.ButtonCancleWrapper>
          <Button color="white" onClick={toggleEditBox}>
            {isEditBoxOpen ? "Save" : "Edit"}
          </Button>

          {isEditBoxOpen && (
            <S.CancleText onClick={toggleEditBox}>
              <div>Cancle</div>
            </S.CancleText>
          )}
        </S.ButtonCancleWrapper>
      </S.IssueTitleNumberButtonWrapper>

      <S.IssueInfoWrapper>
        <Button color="green">Open</Button>
        <S.IssueInfoText>
          <S.UserName>{`${author.userName}`}&nbsp;</S.UserName>
          {` opened this issue ${getTimeTillNow(
            createAt
          )} ago · ${commentLength} comments`}
        </S.IssueInfoText>
      </S.IssueInfoWrapper>
    </S.IssueHeaderWrapper>
  );
}
