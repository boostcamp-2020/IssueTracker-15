import React, { useContext } from "react";
import Label from "../../@types/label-form";
import LabelRow from "../../components/label-row";
import { LabelsContext } from "../../views/label";
import * as S from "./style";

export default function LabelRowContainer() {
  const { labels } = useContext(LabelsContext);

  return (
    <S.LabelRowContainer>
      <S.LabelContainerHeader>{labels?.length} Labels</S.LabelContainerHeader>
      {labels?.map((label: Label) => {
        return <LabelRow key={label.id} label={label} />;
      })}
    </S.LabelRowContainer>
  );
}
