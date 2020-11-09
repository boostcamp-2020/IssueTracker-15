import React from 'react'
import * as S from './style';
import ProfileImage from '../../profile-image';
import IssueSideBarItem from '../item';

interface AsigneeProfileProps {
  userName:string,
  img: string
}

function AssigneeProfile ({userName, img} : AsigneeProfileProps) {
  return (
    <S.AssigneeProfileWrapper>
      <ProfileImage img={img} size={20}/>
      <S.AssigneeName>{userName}</S.AssigneeName>
    </S.AssigneeProfileWrapper>
  )
}

interface LabelProps {
  name: string,
  color: string
}

function Label({name, color} :LabelProps) {
  return (
    <S.LabelWrapper color={color}>{name}</S.LabelWrapper>
  )
}


export default function IssueSideBar() {
  return (
    <>
      <IssueSideBarItem menuName="Assignees">
        <div>
          <AssigneeProfile userName="moaikang" img=""/>
          <AssigneeProfile userName="moaikang" img=""/>
        </div>
      </IssueSideBarItem>

      <IssueSideBarItem menuName="Labels">
        <Label name="라벨" color="#A3EEEF"/>
      </IssueSideBarItem>

      <IssueSideBarItem menuName="Milestone">
        <div>Progress Commponent</div>
      </IssueSideBarItem>
    </>
  )
}
