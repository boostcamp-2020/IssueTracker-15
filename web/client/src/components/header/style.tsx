import styled from "styled-components";

export const Header = styled.div`
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  align-items: center;
  background-color: #24292e;
  height: 6rem;
  width: 100%;
  padding: 0rem;
`;

export const TitleContainer = styled.div`
  display: flex;
  justify-content: center;
  align-items: flex-end;
  padding-bottom: 0.5rem;
  color: white;
  height: 4rem;
  width: 100%;
`;

export const TitleText = styled.div`
  display: flex;
  justify-content: center;
  align-items: flex-end;
  color: white;
  font-size: x-large;
  width: 100%;
`;

export const ButtonRow = styled.div`
  display: flex;
  justify-content: flex-end;
  align-items: center;
  height: 1rem;
  width: 100%;
  padding-right: 4rem;
  margin-bottom: 1rem;
`;

export const ButtonContainer = styled.div`
  display: flex;
  justify-content: center;
  align-items: center;
`;

export const joinButton = styled.div`
  display: flex;
  justify-content: center;
  align-items: center;
  color: white;
  padding: 0rem 0.5rem;
  :hover {
    cursor: pointer;
  }
`;

export const LoginButton = styled.div`
  display: flex;
  justify-content: center;
  align-items: center;
  color: white;
  padding: 0rem 0.5rem;
  :hover {
    cursor: pointer;
  }
`;

export const LogoutButton = styled.div`
  display: flex;
  justify-content: center;
  align-items: center;
  color: white;
  padding: 0rem 0.5rem;
  :hover {
    cursor: pointer;
  }
`;
