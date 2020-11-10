import React, { useState, Fragment } from "react";
import * as S from "./style";

import IssueComp from "./issueComp";

function IssueList() {
  return (
    <S.IssueList>
      <IssueComp />
      <IssueComp />
    </S.IssueList>
  );
}

export default IssueList;
