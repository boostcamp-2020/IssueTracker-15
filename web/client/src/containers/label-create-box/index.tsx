import React from "react";
import Label from "../../components/label";
import LabelEditor from "../../components/label-editor";
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
