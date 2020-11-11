import React, { useState, Fragment } from "react";
import * as S from "./style";
import { AiOutlineExclamationCircle } from "react-icons/ai";
import { VscMilestone } from "react-icons/vsc";
import Label from "../../../label";
import ProfileImage from "../../../profile-image";
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
          <S.LabelWrapper>
            <Label name="FE 💻" color="pink" />
          </S.LabelWrapper>
          <S.LabelWrapper>
            <Label name="Feature 🎨" color="blue" />
          </S.LabelWrapper>
          <S.ProfileImageWrapper size={300}>
            <ProfileImage img="" size={25} />
          </S.ProfileImageWrapper>
          <S.ProfileImageWrapper size={303}>
            <ProfileImage img="" size={25} />
          </S.ProfileImageWrapper>
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
