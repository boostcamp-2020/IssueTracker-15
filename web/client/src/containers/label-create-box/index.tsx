import React, { useContext } from "react";
import Label from "../../components/label";
import LabelEditor from "../../components/label-editor";
import * as S from "./style";
import { LabelHeaderContext } from "../label-list-header";

export default function LabelCreateBox() {
  const { createLabelVisible } = useContext(LabelHeaderContext);

  return (
    <S.LabelCreateBox createLabelVisible={createLabelVisible}>
      <S.LabelContainerRow>
        <Label name="예시" color="#0052CD" />
      </S.LabelContainerRow>
      <LabelEditor></LabelEditor>
    </S.LabelCreateBox>
  );
}
