import React, { useContext } from "react";
import { LabelHeaderContext } from "../../containers/label-list-header";
import Button from "../button";
import * as S from "./style";

export default function LabelEditor() {
  const { setCreateLabel } = useContext(LabelHeaderContext);

  if (!setCreateLabel) throw new Error("ee");

  const toggleCreateLabel = () => {
    setCreateLabel(false);
  };

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
          <Button color="white" onClick={toggleCreateLabel}>
            cancel
          </Button>
          <Button color="green">Create Label</Button>
        </S.ButtonContainer>
      </S.LableInputRow>
    </S.LabelEditor>
  );
}
