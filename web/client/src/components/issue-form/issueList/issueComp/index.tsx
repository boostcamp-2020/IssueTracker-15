import React, { useState, Fragment } from "react";
import * as S from "./style";
import { AiOutlineExclamationCircle } from "react-icons/ai";
import { VscMilestone } from "react-icons/vsc";
import Label from "../../../label";
import { getTimeTillNow } from "../../../../lib/dateParser";
import IssueInfoType from "../../../../@types/issue";
import LabelInfoType from "../../../../@types/label-form";
import ProfileImage from "../../../profile-image";

const START_POS = 850;
const MOVING_POS = 20;
interface IssueCompProp {
  info: IssueInfoType;
}
function IssueComp({ info }: IssueCompProp) {
  const color = info.isOpened ? "green" : "red";
  const mention = info.isOpened ? "opened" : "closed";
  let assigneePos = START_POS;
  return (
    <S.IssueComp>
      <input type="checkbox" name="xxx" value="yyy" />
      <S.ExclamationWrapper>
        <AiOutlineExclamationCircle color={color} />
      </S.ExclamationWrapper>
      <div>
        <S.IssueInfo>
          <S.IssueInfoLink to={`/issue/${info.id}`}>
            {info.title}
          </S.IssueInfoLink>
          {info.labels.map((label: LabelInfoType) => {
            return (
              <S.LabelWrapper>
                <Label name={label.title} color={label.color} />
              </S.LabelWrapper>
            );
          })}
          {info.assignees.map((assignee: any) => {
            assigneePos += MOVING_POS;
            return (
              <S.ProfileImageWrapper size={assigneePos}>
                <ProfileImage img={assignee.imageURL} size={20} />
              </S.ProfileImageWrapper>
            );
          })}
        </S.IssueInfo>
        <S.IssueEtc>
          <S.IssueEtcWrapper>
            #{info.id} by {info.author.userName} was {mention} by{" "}
            {getTimeTillNow(info.createAt)} ago
          </S.IssueEtcWrapper>
          {info.milestone && (
            <div>
              <VscMilestone />
              {info.milestone.title}
            </div>
          )}
        </S.IssueEtc>
      </div>
    </S.IssueComp>
  );
}

export default IssueComp;
