import styled from "styled-components";

export const IssueHeaderWrapper = styled.div`
  margin-top: 1.5rem;
  margin-bottom: 1.5rem;
  padding: 10px 30px;
  width: 100%;
  border-bottom: 1px solid #ccc;
  box-sizing: border-box;
`;

export const IssueTitleNumberButtonWrapper = styled.div`
  display: flex;
  justify-content: space-between;
  align-items: center;

  width: 100%;
`;

export const IssueTitleNumberWrapper = styled.div`
  display: flex;
  font-size: 2.4rem;
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
`;

export const IssueInfoText = styled.div`
  display: flex;

  margin-left: 15px;
`;

export const UserName = styled.strong`
  font-weight: 700;
`;

export const EditBox = styled.input`
  display: block;

  padding: 0.5rem 0.2rem;

  width: 800px;
`;

export const ButtonCancleWrapper = styled.div`
  display: flex;
  align-items: center;
`;

export const CancleText = styled.div`
  display: flex;
  align-items: center;

  margin-left: 10px;
  color: #3c7cdc;

  cursor: pointer;

  &:hover {
    text-decoration: underline;
  }
`;
