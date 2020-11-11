import React, { useState } from "react";
import * as S from "./style";
import FilterListComp from "./filter-list-content";

const Filters = [
  "Author",
  "Label",
  "Projects",
  "Milestones",
  "Assignee",
  "sort",
];
function issueHeader() {
  return (
    <S.IssueHeader>
      <input type="checkbox" name="xxx" value="yyy" checked />
      <S.FilterList>
        {Filters.map((filter) => {
          return <FilterListComp title={filter}></FilterListComp>;
        })}
      </S.FilterList>
    </S.IssueHeader>
  );
}

export default issueHeader;
