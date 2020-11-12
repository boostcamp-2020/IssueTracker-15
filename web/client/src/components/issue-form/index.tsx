import React, { useState } from "react";
import IssueHeader from "./header";
import IssueList from "./issueList";
import * as S from "./style";

// { "제목 " : {{"title" : ~}, {"content" : [] }};
function issueForm() {
  return (
    <S.IssueForm>
      <IssueHeader />
      <IssueList />
    </S.IssueForm>
  );
}

export default issueForm;
