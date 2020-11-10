import React from "react";
import Button from "../button";
import * as S from "./style";

export default function LabelEditor() {
  return (
    <S.LabelEditor>
      <S.LabelTitleRow>
        <S.nameTitle>Label name</S.nameTitle>
        <S.descriptionTitle>Description</S.descriptionTitle>
        <S.colorTitle>Color</S.colorTitle>
      </S.LabelTitleRow>
      <S.LableInputRow>
        <S.inputContainer>
          <S.nameInput />
          <S.descriptionInput />
          <S.colorInputContainer>
            <S.IconContainer>
              <S.refreshIcon />
            </S.IconContainer>
            <S.colorInput />
          </S.colorInputContainer>
        </S.inputContainer>
        <S.ButtonContainer>
          <Button value="cancel" color="white" />
          <Button value="Create Label" color="green" />
        </S.ButtonContainer>
      </S.LableInputRow>
    </S.LabelEditor>
  );
}
