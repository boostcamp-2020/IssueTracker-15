import React, { useState } from "react";
import * as S from "./style";

// { "제목 " : {{"title" : ~}, {"content" : [] }};
function issueHeader() {
  return (
    <S.IssueHeader>
      <input type="checkbox" name="xxx" value="yyy" checked />
    </S.IssueHeader>
  );
}

export default issueHeader;
