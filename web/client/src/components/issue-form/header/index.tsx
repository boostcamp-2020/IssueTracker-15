import React, { useState } from "react";
import * as S from "./style";
import FilterListComp from "./filter-list-content";

// { "제목 " : {{"title" : ~}, {"content" : [] }};
function issueHeader() {
  return (
    <S.IssueHeader>
      <input type="checkbox" name="xxx" value="yyy" checked />
      <S.FilterList>
        <FilterListComp title="Author"></FilterListComp>
        <FilterListComp title="Label"></FilterListComp>
        <FilterListComp title="Projects"></FilterListComp>
        <FilterListComp title="Milestones"></FilterListComp>
        <FilterListComp title="Assignee"></FilterListComp>
        <FilterListComp title="sort"></FilterListComp>
      </S.FilterList>
    </S.IssueHeader>
  );
}

export default issueHeader;
