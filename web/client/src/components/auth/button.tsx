import React, { Fragment } from "react";
import * as S from "./style";

interface BtnProps {
  btnName: string;
}
function Button(props: BtnProps) {
  return <S.BtnAuth> {props.btnName} </S.BtnAuth>;
}

export default Button;
