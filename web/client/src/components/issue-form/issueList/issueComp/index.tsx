import React, { useState, Fragment } from "react";
import * as S from "./style";
import { AiOutlineExclamationCircle } from "react-icons/ai";
import { VscMilestone } from "react-icons/vsc";

function IssueList() {
  return (
    <S.IssueComp>
      <input type="checkbox" name="xxx" value="yyy" checked />
      <S.ExclamationWrapper>
        <AiOutlineExclamationCircle color="green" />
      </S.ExclamationWrapper>
      <div>
        <S.IssueInfo>
          <S.IssueTitle> 제목 </S.IssueTitle>
        </S.IssueInfo>
        <S.IssueEtc>
          <S.IssueEtcWrapper>
            #4 by heramoon was closed by 8 days ago
          </S.IssueEtcWrapper>
          <VscMilestone />
          스프린트2
        </S.IssueEtc>
      </div>
    </S.IssueComp>
  );
}

export default IssueList;
