import React, { Fragment } from "react";
import InputTitle from "./input-title";
import * as S from "./style";

interface InputProps {
  title: string;
  name: string;
}
function Input(props: InputProps) {
  return (
    <S.InputWrap>
      <InputTitle title={props.title} />
      <S.InputBox type="text" name={props.name} autoComplete="off" />
    </S.InputWrap>
  );
}

export default Input;
