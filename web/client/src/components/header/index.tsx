import React from "react";
import * as S from "./style";
import Modal from "../modal";
import Login from "../auth/login";
import useToggle from "../../hooks/useToggle";

export default function Header() {
  const [isOpen, setIsOpen] = useToggle(false);
  return (
    <>
      <S.Header>
        <S.TitleContainer>
          <S.TitleText>Issues</S.TitleText>
        </S.TitleContainer>
        <S.ButtonRow>
          <S.ButtonContainer>
            <S.joinButton>회원가입</S.joinButton>
            <S.LoginButton onClick={setIsOpen}>로그인</S.LoginButton>
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
