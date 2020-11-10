import React, { useState } from "react";
import * as S from "./style";
import DropdownContent from "./dropdown-content";
import DropdownTitle from "./dropdown-title";

interface dropdownProps {
  title: string;
  contents: any[];
}

// { "제목 " : {{"title" : ~}, {"content" : [] }};
function Dropdown({ title, contents }: dropdownProps) {
  const [isVisible, setIsVisible] = useState(false);

  return (
    <S.DropdownWrapper>
      <DropdownTitle title={title} />
      <S.ListWrapper>
        {contents.map((element: any) => {
          return (
            <DropdownContent
              onClick={element.onClick}
              content={element.content}
            />
          );
        })}
      </S.ListWrapper>
    </S.DropdownWrapper>
  );
}

export default Dropdown;
