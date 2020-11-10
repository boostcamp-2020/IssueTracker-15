import styled from 'styled-components';

export const IssueHeaderWrapper = styled.div`
  width: 100vw;
  padding: 10px 30px;

  box-sizing: border-box;
`;

export const IssueTitleNumberButtonWrapper = styled.div`
  display: flex;
  justify-content: space-between;
  align-items: center;
`;

export const IssueTitleNumberWrapper = styled.div`
  display: flex;
  font-size: 2rem;
`;

export const IssueTitle = styled.div`
  margin-right: 10px;
`;

export const IssueNumber = styled.div`
  color: #6a737d;
`;

export const IssueInfoWrapper = styled.div`
  display: flex;
  align-items: center;

  margin-top: 15px;
  padding-bottom: 25px;

  color: #586069;

  border-bottom: 1px solid #ccc;
`;

export const IssueInfoText = styled.div`
  display: flex;

  margin-left: 15px;
`;

export const UserName = styled.strong`
  font-weight: 700;
`;
