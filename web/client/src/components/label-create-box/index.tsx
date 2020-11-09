import React from "react";
import Label from "../label";
import LabelEditor from "../label-editor";
import * as S from "./style";

export default function LabelCreateBox() {
  return (
    <S.LabelCreateBox>
      <S.LabelContainerRow>
        <Label name="예시" color="#0052CD" />
      </S.LabelContainerRow>
      <LabelEditor></LabelEditor>
    </S.LabelCreateBox>
  );
}
