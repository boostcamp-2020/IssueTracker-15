import React from "react";
import styled from "styled-components";
import { useParams } from "react-router-dom";

import IssueSideBar from "../components/issue-sidebar/sidebar";
import IssueHeader from "../components/issueHeader";
import CommentBoxContainer from "../containers/commentBox-container";
import useAsync from "../hooks/useAsync";
import * as api from "../lib/api";

const PageGrid = styled.div`
  width: 1280px;
  margin: 0 auto;
`;
const ColumnWrapper = styled.div`
  display: flex;
  justify-content: space-between;
`;
const LeftColumn = styled.div`
  flex-grow: 0.8;
  flex-shrink: 0;
`;

const RightColumn = styled.div`
  flex-shrink: 0;
`;

const DetailIssuePage = () => {
  const params: any = useParams();

  const [state, fetchIssue] = useAsync(() => {
    return api.getIssueById(params.id);
  }, []);

  const { loading, data: issue, error } = state;
  if (loading) return <div>로딩중...</div>;
  if (error) return <div>에러가 났네요;</div>;

  return (
    <PageGrid>
      {issue && (
        <>
          <IssueHeader
            title={issue.title}
            id={issue.id}
            author={issue.author}
            createAt={issue.createAt}
            commentLength={issue.comments.length}
          />

          <ColumnWrapper>
            <LeftColumn>
              {issue.comments.map((comment: any) => (
                <CommentBoxContainer
                  key={comment.id}
                  isAuthor={false}
                  comment={comment}
                />
              ))}
              <CommentBoxContainer isAuthor={true} />
            </LeftColumn>
            <RightColumn>
              <IssueSideBar
                assignees={issue.assignees}
                labels={issue.labels}
                milestone={issue.milestone}
              />
            </RightColumn>
          </ColumnWrapper>
        </>
      )}
    </PageGrid>
  );
};

export default DetailIssuePage;
