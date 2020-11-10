import React, { useState } from "react";
import * as S from "./style";
import Dropdown from "../dropdown";
import NavButton from "../nav-button";

const DropdownContents = {
  title: "Filter Issues",
  contents: [
    "Open Issues",
    "Your Issues",
    "Everything assigned to you",
    "Everything mentioning to you",
    "Closed Issues",
  ],
};

function IssueFilterBar() {
  const [isOpen, setIsOpen] = useState(false);
  const toggleDropdown = () => setIsOpen(!isOpen);

  return (
    <S.FilterBar>
      <S.FilterContainer>
        <S.FilterWrapper>
          <S.FilterForm>
            <S.FilterComp onClick={toggleDropdown}>Filters</S.FilterComp>
            {isOpen && <Dropdown {...DropdownContents} />}
          </S.FilterForm>
        </S.FilterWrapper>
        <S.SearchForm>is:issue is:open</S.SearchForm>
      </S.FilterContainer>
      <NavButton classify={"label"} />
      <NavButton classify={"milestone"} />
    </S.FilterBar>
  );
}

export default IssueFilterBar;
