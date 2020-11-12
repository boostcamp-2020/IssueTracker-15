import React, { useState, useEffect } from "react";
import * as S from "./style";
import { VscMilestone } from "react-icons/vsc";
import { BiLabel } from "react-icons/bi";
import { getMilestones, getLabels } from "../../lib/api";

interface NavButtonProps {
  classify: string;
}

const milestoneConf = {
  width: "100%",
  title: "milestone",
};

const labelConf = {
  width: "100%",
  title: "Label",
};

function NavButton({ classify }: NavButtonProps) {
  const [count, setCount] = useState(0);
  const conf = classify === "milestone" ? milestoneConf : labelConf;

  useEffect(() => {
    const getMilestoneCount = async () => {
      const result =
        classify === "milestone"
          ? (await getMilestones()).length
          : (await getLabels()).length;
      setCount(result);
    };
    getMilestoneCount();
  }, []);
  return (
    <S.NavButton width={conf.width}>
      {classify === "milestone" ? <VscMilestone /> : <BiLabel />}
      <S.NavButtonTitle> {conf.title}</S.NavButtonTitle>
      <S.NavButtonCountWrapper>{count}</S.NavButtonCountWrapper>
    </S.NavButton>
  );
}

export default NavButton;
