import React, { Fragment } from "react";
import Input from "./input-form";
import Button from "./button";
import * as S from "./style";

function Login() {
  return (
    <Fragment>
      <Input title="이메일" name="email" />
      <Input title="비밀번호" name="password" />
      <S.WrapBtnForm>
        <Button btnName="로그인" />
        <Button btnName="회원가입" />
      </S.WrapBtnForm>
    </Fragment>
  );
}
export default Login;
