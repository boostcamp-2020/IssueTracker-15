import React, {
  useCallback,
  useContext,
  useEffect,
  useRef,
  useState,
} from "react";
import LabelForm from "../../@types/label-form";
import { deleteLabelReqeust } from "../../lib/api";
import Label, { LabelProps } from "../label";
import { LabelsContext } from "../../views/label";
import LabelEditor from "../label-editor";
import * as S from "./style";
import { PostLabel } from "../../@types/label-form";

export default function LabelRow({ label }: { label: LabelForm }) {
  const { labels, setLabels, editBoxToggle, setEditBoxToggle } = useContext(
    LabelsContext
  );
  const [editedLabel, setEditedLabel] = useState(
    label ? label : ({} as PostLabel)
  );
  const [labelColor, setLabelColor] = useState(label.color ? label.color : "");

  const toggleEditBox = useCallback(() => {
    setEditBoxToggle(label.id);
  }, [editBoxToggle]);

  const deleteLabel = useCallback(async () => {
    confirm(`${label.title} 을 정말 삭제하시겠습니까?`);
    const result = await deleteLabelReqeust(label.id);
    if (!result.ok) return;

    setLabels(labels.filter((l) => l.id !== label.id));
  }, [labels]);

  return (
    <S.LabelRowContainer>
      <S.LabelRow>
        <S.LabelContainer>
          <Label name={label.title} color={labelColor} />
        </S.LabelContainer>
        <S.LabelDescription>{label.description}</S.LabelDescription>
        <S.LabelControllButtonContainer>
          <S.LabelControllbutton onClick={toggleEditBox}>
            Edit
          </S.LabelControllbutton>
          <S.LabelControllbutton onClick={deleteLabel}>
            Delete
          </S.LabelControllbutton>
        </S.LabelControllButtonContainer>
      </S.LabelRow>
      <LabelEditor
        newLabel={editedLabel}
        setNewLabel={setEditedLabel}
        labelColor={labelColor}
        setLabelColor={setLabelColor}
        labelId={label.id}
      ></LabelEditor>
    </S.LabelRowContainer>
  );
}
