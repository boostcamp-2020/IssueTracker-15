import React, { Fragment } from "react";
import * as S from "./style";

interface BtnProps {
  btnName: string;
}
function AuthButton(props: BtnProps) {
  return <S.BtnAuth> {props.btnName} </S.BtnAuth>;
}

export default AuthButton;
