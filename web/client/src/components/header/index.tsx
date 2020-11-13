import React from "react";
import * as S from "./style";
import Modal from "../modal";
import Login from "../auth/login";
import useToggle from "../../hooks/useToggle";

export default function Header() {
  const [isOpen, setIsOpen] = useToggle(false);
  const accessToken = localStorage.getItem("accessToken");

  return (
    <>
      <S.Header>
        <S.TitleContainer to="/">
          <S.TitleText>Issues</S.TitleText>
        </S.TitleContainer>
        <S.ButtonRow>
          <S.ButtonContainer>
            {accessToken ? (
              <>
                <S.joinButton>회원가입</S.joinButton>
                <S.LoginButton onClick={setIsOpen}>로그인</S.LoginButton>{" "}
              </>
            ) : (
              <>
                <S.LogoutButton>로그아웃</S.LogoutButton>
              </>
            )}
          </S.ButtonContainer>
        </S.ButtonRow>
      </S.Header>
      {isOpen && (
        <Modal>
          <Login />
        </Modal>
      )}
    </>
  );
}
