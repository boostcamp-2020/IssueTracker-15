import React from "react";
import * as S from "./style";
import Dropdown from "../dropdown";
import IssueSideBar from "../issue-sidebar/sidebar";

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
  return (
    <S.FilterBar>
      <S.FilterWrapper>
        <S.FilterForm>
          <S.FilterComp>Filters</S.FilterComp>
          <Dropdown {...DropdownContents} />
        </S.FilterForm>
      </S.FilterWrapper>
      <S.SearchForm>is:issue is:open</S.SearchForm>
    </S.FilterBar>
  );
}

export default IssueFilterBar;
