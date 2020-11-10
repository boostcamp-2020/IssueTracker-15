import React, { useState } from "react";
import { Link } from "react-router-dom";
import * as S from "./style";
import Dropdown from "../dropdown";
import NavButton from "../nav-button";
import useToggle from "../../hooks/useToggle";
import { BiCaretDown } from "react-icons/bi";

function IssueFilterBar(this: any) {
  const [filterCmd, setFilterCmd] = useState("is:issue is:open");
  const [isOpen, setIsOpen] = useToggle(false);

  const onClickDropdownContent = (props: string) => {
    setFilterCmd(props);
  };

  const DropdownContents = {
    title: "Filter Issues",
    contents: [
      {
        content: "Open Issues",
        onClick: onClickDropdownContent.bind(this, "is:issue is:open"),
      },
      {
        content: "Your Issues",
        onClick: onClickDropdownContent.bind(
          this,
          "is:open is:issue author:@me"
        ),
      },
      {
        content: "Everything assigned to you",
        onClick: onClickDropdownContent.bind(this, "is:open assignee:@me"),
      },
      {
        content: "Closed Issues",
        onClick: onClickDropdownContent.bind(this, "is:close is:issue"),
      },
    ],
  };

  return (
    <S.FilterBar>
      <S.FilterContainer>
        <S.FilterWrapper>
          <S.FilterForm>
            <S.FilterComp onClick={setIsOpen}>Filters</S.FilterComp>
            {isOpen && <Dropdown {...DropdownContents} />}
            <BiCaretDown />
          </S.FilterForm>
        </S.FilterWrapper>
        <S.SearchForm>{filterCmd}</S.SearchForm>
      </S.FilterContainer>
      <NavButton classify={"label"} count={2} />
      <NavButton classify={"milestone"} count={3} />
    </S.FilterBar>
  );
}

export default IssueFilterBar;
