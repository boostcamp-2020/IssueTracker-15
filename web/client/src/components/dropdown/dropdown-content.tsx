import React from "react";
import * as S from "./style";

interface DropdownContentProps {
  content: string;
}
function DropdownContent(props: DropdownContentProps) {
  return <S.DropdownContent>Open Issues</S.DropdownContent>;
}

export default DropdownContent;
