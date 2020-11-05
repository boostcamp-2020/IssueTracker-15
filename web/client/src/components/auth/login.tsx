import React, { Fragment } from "react";
import styled from "styled-components";
import Input from "./input-form";
import Button from "./button";
const WrapBtnForm = styled.div`
  display: flex;
  justify-content: space-around;
`;
function Login() {
  return (
    <Fragment>
      <Input title="이메일" name="email" />
      <Input title="비밀번호" name="password" />
      <WrapBtnForm>
        <Button btnName="로그인" />
        <Button btnName="회원가입" />
      </WrapBtnForm>
    </Fragment>
  );
}
export default Login;
