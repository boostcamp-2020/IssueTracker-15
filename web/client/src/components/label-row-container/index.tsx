import React from "react";
import LabelForm from "../../@types/label-form";
import LabelRow from "../label-row";
import * as S from "./style";

export default function LabelRowContainer() {
  const labels: LabelForm[] = [
    { title: "backend", color: "#ff0000", description: "바보같이 굴지말기" },
    { title: "frontend", color: "#bba333", description: "예쁘게 디자인" },
    { title: "기어 second", color: "#2ea44f", description: "오늘 달린다" },
  ];

  return (
    <S.LabelRowContainer>
      {labels.map((label) => {
        return <LabelRow label={label} />;
      })}
    </S.LabelRowContainer>
  );
}
