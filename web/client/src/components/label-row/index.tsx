import React from "react";
import LabelForm from "../../@types/label-form";
import Label from "../label";
import * as S from "./style";

export default function LabelRow({ label }: { label: LabelForm }) {
  return (
    <S.LabelRow>
      <Label name={label.title} color={label.color} />
      <S.LabelDescription>{label.description}</S.LabelDescription>
      <S.LabelControllButtonContainer>
        <S.LabelControllbutton>Edit</S.LabelControllbutton>
        <S.LabelControllbutton>Delete</S.LabelControllbutton>
      </S.LabelControllButtonContainer>
    </S.LabelRow>
  );
}
