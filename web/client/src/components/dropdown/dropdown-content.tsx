import React from "react";
import * as S from "./style";

interface DropdownContentProps {
  content: string;
  onClick?: () => void;
}
function DropdownContent({ content, onClick }: DropdownContentProps) {
  return <S.DropdownContent onClick={onClick}>{content}</S.DropdownContent>;
}

export default DropdownContent;
