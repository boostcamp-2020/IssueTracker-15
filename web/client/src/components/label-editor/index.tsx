import React, {
  Dispatch,
  SetStateAction,
  useContext,
  useEffect,
  useRef,
} from "react";
import { LabelHeaderContext } from "../../containers/label-list-header";
import Button from "../button";
import * as S from "./style";

interface LabelEditorProps {
  labelContent: string;
  setLabelContent: Dispatch<SetStateAction<string>>;
  labelColor: string;
  setLabelColor: Dispatch<SetStateAction<string>>;
}

export default function LabelEditor(props: LabelEditorProps) {
  const { setCreateLabel } = useContext(LabelHeaderContext);

  if (!setCreateLabel) throw new Error("ee");

  const toggleCreateLabel = () => {
    setCreateLabel(false);
  };

  const colorInput = useRef(null);
  const changeLabelContent = (e: React.ChangeEvent<HTMLInputElement>) => {
    props.setLabelContent(e.target.value);
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
          <S.nameInput placeholder="Label name" onChange={changeLabelContent} />
          <S.descriptionInput placeholder="Description (optional)" />
          <S.colorInputContainer>
            <S.IconContainer>
              <S.refreshIcon />
            </S.IconContainer>
            <S.colorInput value={"#0052CD"} ref={colorInput} />
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
