import React, { useContext, useState } from "react";
import Label from "../../components/label";
import LabelEditor from "../../components/label-editor";
import * as S from "./style";
import { LabelHeaderContext } from "../label-list-header";

import { PostLabel } from "../../@types/label-form";
import { couldStartTrivia } from "typescript";

export default function LabelCreateBox() {
  const { createLabelVisible } = useContext(LabelHeaderContext);
  const [labelContent, setLabelContent] = useState("exapmle");
  const [labelColor, setLabelColor] = useState("#0052CD");
  const [newLabel, setNewLabel] = useState({} as PostLabel);

  console.log(newLabel);

  return (
    <S.LabelCreateBox createLabelVisible={createLabelVisible}>
      <S.LabelContainerRow>
        <Label name={labelContent} color={labelColor} />
      </S.LabelContainerRow>
      <LabelEditor
        isCreate={true}
        labelContent={labelContent}
        setLabelContent={setLabelContent}
        labelColor={labelColor}
        setLabelColor={setLabelColor}
        newLabel={newLabel}
        setNewLabel={setNewLabel}
      ></LabelEditor>
    </S.LabelCreateBox>
  );
}
