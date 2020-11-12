import React, { useContext, useState } from "react";
import Label from "../../components/label";
import LabelEditor from "../../components/label-editor";
import * as S from "./style";
import { LabelHeaderContext } from "../label-list-header";

export default function LabelCreateBox() {
  const { createLabelVisible } = useContext(LabelHeaderContext);
  const [labelContent, setLabelContent] = useState("exapmle");
  const [labelColor, setLabelColor] = useState("#0052CD");

  return (
    <S.LabelCreateBox createLabelVisible={createLabelVisible}>
      <S.LabelContainerRow>
        <Label name={labelContent} color={labelColor} />
      </S.LabelContainerRow>
      <LabelEditor
        labelContent={labelContent}
        setLabelContent={setLabelContent}
        labelColor={labelColor}
        setLabelColor={setLabelColor}
      ></LabelEditor>
    </S.LabelCreateBox>
  );
}
