import React, { useEffect } from "react";
import styled from "styled-components";
import { useParams } from "react-router-dom";

import IssueSideBar from "../../components/issue-sidebar/sidebar";
import IssueHeader from "../../components/issueHeader";
import CommentBoxContainer from "../../containers/commentBox-container";
import useAsync from "../../hooks/useAsync";
import * as api from "../../lib/api";
import * as S from "./style";
import {
  getIssueById,
  useIssueDetailDispatch,
  useIssueDetailState,
} from "../../contexts/issueDetailContext";

const DetailIssuePage = () => {
  const params: any = useParams();
  const issueDetailState = useIssueDetailState();
  const issueDetailDispatch = useIssueDetailDispatch();

  useEffect(() => {
    getIssueById(issueDetailDispatch, params.id);
  }, []);

  const { loading, data: issue, error } = issueDetailState.issue;
  if (loading) return <div>로딩중...</div>;
  if (error) return <div>에러가 났네요;</div>;
  if (!issue) return <div>해당하는 id의 이슈가 없어요!</div>;

  return (
    <>
      {issue && (
        <S.PageGrid>
          <IssueHeader
            title={issue.title}
            id={issue.id}
            author={issue.author}
            createAt={issue.createAt}
            isOpened={issue.isOpened}
            commentLength={issue.comments.length}
          />

          <S.ColumnWrapper>
            <S.LeftColumn>
              {issue.comments.map((comment: any) => (
                <CommentBoxContainer
                  key={comment.id}
                  isAuthor={false}
                  comment={comment}
                />
              ))}
              <CommentBoxContainer isAuthor={true} />
            </S.LeftColumn>
            <S.RightColumn>
              <IssueSideBar
                assignees={issue.assignees}
                labels={issue.labels}
                milestone={issue.milestone}
              />
            </S.RightColumn>
          </S.ColumnWrapper>
        </S.PageGrid>
      )}
    </>
  );
};

export default DetailIssuePage;
