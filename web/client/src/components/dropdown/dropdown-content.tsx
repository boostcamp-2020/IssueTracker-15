import React from "react";
import * as S from "./style";

interface DropdownContentProps {
  content: string;
}
function DropdownContent(props: DropdownContentProps) {
  return <S.DropdownContent>{props.content}</S.DropdownContent>;
}

export default DropdownContent;
