import React, { useCallback, useContext } from "react";
import LabelForm from "../../@types/label-form";
import { LabelsContext } from "../../containers/label-row-container";
import { deleteLabelReqeust } from "../../lib/api";
import Label from "../label";
import LabelEditor from "../label-editor";
import * as S from "./style";

export default function LabelRow({ label }: { label: LabelForm }) {
  const { labels, setLabels } = useContext(LabelsContext);

  const deleteLabel = useCallback(async () => {
    const result = await deleteLabelReqeust(label.id);
    if (!result.ok) return;

    setLabels(labels.filter((l) => l.id !== label.id));
  }, [labels]);

  return (
    <S.LabelRowContainer>
      <S.LabelRow>
        <S.LabelContainer>
          <Label name={label.title} color={label.color} />
        </S.LabelContainer>
        <S.LabelDescription>{label.description}</S.LabelDescription>
        <S.LabelControllButtonContainer>
          <S.LabelControllbutton>Edit</S.LabelControllbutton>
          <S.LabelControllbutton onClick={deleteLabel}>
            Delete
          </S.LabelControllbutton>
        </S.LabelControllButtonContainer>
      </S.LabelRow>
    </S.LabelRowContainer>
  );
}
