import React, { useState, Fragment } from "react";
import * as S from "./style";

function IssueList() {
  return (
    <S.IssueComp>
      <input type="checkbox" name="xxx" value="yyy" checked />
      <div>
        <S.IssueInfo>
          <S.IssueTitle> 제목 </S.IssueTitle>
        </S.IssueInfo>
        <S.IssueEtc>#4 by heramoon was closed by 8 days ago</S.IssueEtc>
      </div>
    </S.IssueComp>
  );
}

export default IssueList;
