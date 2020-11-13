import React from "react";
import * as S from "./style";

interface DropdownTitleProps {
  title: string;
}
function DropdownTitle(props: DropdownTitleProps) {
  return <S.DropdownTitle>{props.title}</S.DropdownTitle>;
}

export default DropdownTitle;
