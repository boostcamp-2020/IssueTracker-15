import React from "react";
import * as S from "./style";
import DropdownContent from "./dropdown-content";
import DropdownTitle from "./dropdown-title";

interface dropdownProps {
  title: string;
  contents: string[];
}
// { "제목 " : {{"title" : ~}, {"content" : [] }};
function Dropdown({ title, contents }: dropdownProps) {
  return (
    <S.DropdownWrapper>
      <DropdownTitle title={title} />
      <S.ListWrapper>
        {contents.map((content: string) => {
          <DropdownContent content={content} />;
        })}
      </S.ListWrapper>
    </S.DropdownWrapper>
  );
}

export default Dropdown;
/*
<S.DropdownWrapper>
    <ListTitle>Filter Issues </ListTitle>
    <S.ListWrapper>
      <ListComp>Open Issues</ListComp>
      <ListComp>Your Issues </ListComp>
      <ListComp>Everything assigned to you</ListComp>
      <ListComp>Everything mentioning to you</ListComp>
      <ListComp>Closed Issues</ListComp>
    </S.ListWrapper>
  </S.DropdownWrapper>;
*/
