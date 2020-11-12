import React from "react";
import * as S from "./style";
import ProfileImage from "../../profile-image";
import IssueSideBarItem from "../item";
import Label from "../../label";
import LabelForm from "../../../@types/label-form";
import Milestone from "../../../@types/milestone";

interface AsigneeProfileProps {
  userName: string;
  img: string;
}

function AssigneeProfile({ userName, img }: AsigneeProfileProps) {
  return (
    <S.AssigneeProfileWrapper>
      <ProfileImage img={img} size={20} />
      <S.AssigneeName>{userName}</S.AssigneeName>
    </S.AssigneeProfileWrapper>
  );
}

interface LabelProps {
  name: string;
  color: string;
}

interface IssueSideBarProps {
  assignees: { userName: string; imageURL: string }[];
  labels: LabelForm[];
  milestone: Milestone;
}

export default function IssueSideBar({
  assignees,
  labels,
  milestone,
}: IssueSideBarProps) {
  console.log(milestone);
  return (
    <>
      <IssueSideBarItem menuName="Assignees">
        <div>
          {assignees.map((assignee) => (
            <AssigneeProfile
              userName={assignee.userName}
              img={assignee.imageURL}
            />
          ))}
        </div>
      </IssueSideBarItem>

      <IssueSideBarItem menuName="Labels">
        <S.LabelsWrapper>
          {labels.map((label) => (
            <S.MarginLabel color={label.color}>{label.title}</S.MarginLabel>
          ))}
        </S.LabelsWrapper>
      </IssueSideBarItem>

      <IssueSideBarItem menuName="Milestone">
        <div>{milestone ? milestone.title : "마일스톤이 없습니다!"}</div>
      </IssueSideBarItem>
    </>
  );
}
