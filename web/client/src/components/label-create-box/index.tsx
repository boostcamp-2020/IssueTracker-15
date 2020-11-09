import React from "react";
import Label from "../label";
import LabelEditor from "../label-editor";
import * as S from "./style";

export interface LabelCreateBoxProps {
  visible: boolean;
}

export default function LabelCreateBox({ visible }: LabelCreateBoxProps) {
  return (
    <S.LabelCreateBox visible={visible}>
      <S.LabelContainerRow>
        <Label name="예시" color="#0052CD" />
      </S.LabelContainerRow>
      <LabelEditor></LabelEditor>
    </S.LabelCreateBox>
  );
}
