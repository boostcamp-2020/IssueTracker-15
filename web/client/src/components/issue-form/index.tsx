import React, { useState } from "react";
import IssueHeader from "./header";
import * as S from "./style";

// { "제목 " : {{"title" : ~}, {"content" : [] }};
function issueForm() {
  return (
    <S.IssueForm>
      <IssueHeader></IssueHeader>
    </S.IssueForm>
  );
}

export default issueForm;
