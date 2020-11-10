import React from "react";
import * as S from "./style";

interface DropdownTitleProps {
  title: string;
}
function DropdownContent(props: DropdownTitleProps) {
  return <S.DropdownTitle>{props.title}</S.DropdownTitle>;
}

export default DropdownContent;
