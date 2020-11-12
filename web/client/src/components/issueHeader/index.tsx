import React, { useCallback, useState } from "react";

import * as S from "./style";
import * as api from "../../lib/api";
import { getTimeTillNow } from "../../lib/dateParser";
import Button from "../button";
import useToggle from "../../hooks/useToggle";
import useAsync from "../../hooks/useAsync";
import { useIssueDetailState } from "../../contexts/issueDetailContext";

interface IssueProps {
  title: string;
  id: number;
  isOpened: boolean;
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
  isOpened,
}: IssueProps) {
  const [isEditBoxOpen, setIsEditBoxOpen] = useToggle(false);
  const [isTitleUpdate, setIsTitleUpdate] = useState(false);

  const toggleEditBox = useCallback(setIsEditBoxOpen, [isEditBoxOpen]);

  const issueDetailState = useIssueDetailState();

  const [editBoxValue, setEditBox] = useState(title);
  const changeEditBox = (e: any) => {
    const { value } = e.target;
    setEditBox(value);
  };

  return (
    <S.IssueHeaderWrapper>
      <S.IssueTitleNumberButtonWrapper>
        <S.IssueTitleNumberWrapper>
          {!isEditBoxOpen && (
            <>
              <S.IssueTitle>
                {isTitleUpdate ? editBoxValue : title}
              </S.IssueTitle>
              <S.IssueNumber>#{id}</S.IssueNumber>
            </>
          )}
          {isEditBoxOpen && (
            <S.EditBox
              autoFocus={true}
              value={editBoxValue}
              onChange={changeEditBox}
            />
          )}
        </S.IssueTitleNumberWrapper>

        <S.ButtonCancleWrapper>
          <Button
            color="white"
            onClick={
              !isEditBoxOpen
                ? toggleEditBox
                : async () => {
                    const result = await api.updateIssueTitle(id, editBoxValue);
                    setIsTitleUpdate(true);
                    toggleEditBox();
                  }
            }
          >
            {isEditBoxOpen ? "Save" : "Edit"}
          </Button>

          {isEditBoxOpen && (
            <S.CancleText
              onClick={() => {
                toggleEditBox();
                setEditBox(title);
              }}
            >
              <div>Cancle</div>
            </S.CancleText>
          )}
        </S.ButtonCancleWrapper>
      </S.IssueTitleNumberButtonWrapper>

      <S.IssueInfoWrapper>
        <Button
          color={isOpened ? "green" : "white"}
          onClick={async () => {
            if (!isOpened) return;
            if (window.confirm("이슈를 닫겠습니까?")) {
              await api.closeIssue(id);
              window.location.reload(false);
            }
          }}
        >
          {isOpened ? "Open" : "Close"}
        </Button>
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
