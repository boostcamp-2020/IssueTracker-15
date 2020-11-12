import React, { useContext, useState } from "react";
import Label from "../../components/label";
import LabelEditor from "../../components/label-editor";
import * as S from "./style";
import { LabelHeaderContext } from "../label-list-header";

import { PostLabel } from "../../@types/label-form";
import { couldStartTrivia } from "typescript";
import { getRandomColor } from "../../lib/label-color";

export default function LabelCreateBox() {
  const { createLabelVisible } = useContext(LabelHeaderContext);
  const [labelContent, setLabelContent] = useState("exapmle");
  const [labelColor, setLabelColor] = useState(getRandomColor());
  const [newLabel, setNewLabel] = useState({ color: labelColor } as PostLabel);

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
