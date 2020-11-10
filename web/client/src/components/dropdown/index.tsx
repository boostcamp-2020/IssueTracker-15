import React from "react";
import * as S from "./style";
import DropdownContent from "./dropdown-content";
import DropdownTitle from "./dropdown-title";

interface dropdownProps {
  title: string;
  contents: string[];
  isVisible: boolean;
}

// { "제목 " : {{"title" : ~}, {"content" : [] }};
function Dropdown<IProps_Squre>(props: dropdownProps) {
  return (
    <S.DropdownWrapper isVisible={props.isVisible}>
      <DropdownTitle title={props.title} />
      <S.ListWrapper>
        {props.contents.map((content: string) => {
          console.log(content);
          return <DropdownContent content={content} />;
        })}
      </S.ListWrapper>
    </S.DropdownWrapper>
  );
}

export default Dropdown;
