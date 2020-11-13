import React, { Fragment } from "react";
import Input from "./input-form";
import AuthButton from "./button";
import * as S from "./style";

function Login() {
  return (
    <Fragment>
      <Input title="이메일" name="email" />
      <Input title="비밀번호" name="password" />
      <S.WrapBtnForm>
        <AuthButton btnName="로그인" />
        <AuthButton btnName="회원가입" />
      </S.WrapBtnForm>
      <S.GitHubBTN
        onClick={() => {
          window.open(
            "https://github.com/login/oauth/authorize?client_id=bbd8f4faffe4f6f9c9b7&redirect_uri=http://localhost:8080/auth/github",
            "_self"
          );
        }}
      />
    </Fragment>
  );
}
export default Login;
