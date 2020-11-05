import React from "react";
import * as S from "./style";

interface HeaderProps {}

export default function Header() {
  return (
    <>
      <S.Header>
        <S.TitleContainer>
          <S.TitleText>Issues</S.TitleText>
        </S.TitleContainer>
        <S.ButtonRow>
          <S.ButtonContainer>
            <S.joinButton>회원가입</S.joinButton>
            <S.LoginButton>로그인</S.LoginButton>
          </S.ButtonContainer>
        </S.ButtonRow>
      </S.Header>
    </>
  );
}
