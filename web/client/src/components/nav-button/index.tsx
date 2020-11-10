import React from "react";
import * as S from "./style";
import { VscMilestone } from "react-icons/vsc";
import { BiLabel } from "react-icons/bi";

interface NavButtonProps {
  classify?: string;
}

const milestoneConf = {
  width: "15%",
  title: "milestone",
  //onClick 넣어줘야 함
};

const labelConf = {
  width: "10%",
  title: "Label",
  // onClick 넣어줘야 함
};

const labelNavButton = {};
function NavButton({ classify }: NavButtonProps) {
  const conf = classify === "milestone" ? milestoneConf : labelConf;
  return (
    <S.NavButton width={conf.width}>
      {classify === "milestone" ? <VscMilestone /> : <BiLabel />}
      <S.NavButtonTitle> {conf.title}</S.NavButtonTitle>
    </S.NavButton>
  );
}

export default NavButton;
