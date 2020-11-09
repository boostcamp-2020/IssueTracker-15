import React, { Fragment } from "react";
import * as S from "./style";

interface TitleProps {
  title: string;
}
function InputTitle(props: TitleProps) {
  return <S.TitleInputWrapAuth>{props.title}</S.TitleInputWrapAuth>;
}

export default InputTitle;
