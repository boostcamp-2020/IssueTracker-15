import React from 'react';
import styled from 'styled-components';

const IssueHeaderWrapper = styled.div``;
const IssueTitleComponent = styled.div`
  font-size: 3rem;
`;
const IssueIDCompoenent = styled.div``;

interface issue {
  issueTitle: string;
  issueID: number;
}

export default function IssueHeader({ issueTitle, issueID }: issue) {
  return (
    <>
      <IssueHeaderWrapper>
        <IssueTitleComponent>{issueTitle}</IssueTitleComponent>
        <IssueIDCompoenent># {issueID}</IssueIDCompoenent>
      </IssueHeaderWrapper>
    </>
  );
}
