import React, {
  Dispatch,
  SetStateAction,
  useContext,
  useCallback,
  useRef,
} from "react";
import { LabelHeaderContext } from "../../containers/label-list-header";
import Button from "../button";
import * as S from "./style";
import { LabelsContext } from "../../views/label";

interface LabelEditorProps {
  isCreate?: boolean;
  labelId?: number;
  labelContent?: string;
  setLabelContent?: Dispatch<SetStateAction<string>>;
  labelColor?: string;
  setLabelColor?: Dispatch<SetStateAction<string>>;
}

export default function LabelEditor(props: LabelEditorProps) {
  const { setCreateLabel } = useContext(LabelHeaderContext);
  const { editBoxToggle, setEditBoxToggle } = useContext(LabelsContext);

  const toggleCreateLabel = () => {
    if (setCreateLabel) {
      setCreateLabel(false);
    }
  };

  const colorInput = useRef(null);

  const changeLabelContent = (e: React.ChangeEvent<HTMLInputElement>) => {
    if (props.setLabelContent) {
      props.setLabelContent(e.target.value);
    }
  };

  const toggleEditBox = useCallback(() => {
    setEditBoxToggle(0);
  }, [editBoxToggle]);

  return (
    <S.LabelEditor
      isCreate={props.isCreate}
      labelId={props.labelId}
      visible={editBoxToggle}
    >
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
            <S.colorInput defaultValue={"#0052CD"} ref={colorInput} />
          </S.colorInputContainer>
        </S.inputContainer>
        <S.ButtonContainer>
          <Button
            color="white"
            onClick={setCreateLabel ? toggleCreateLabel : toggleEditBox}
          >
            cancel
          </Button>
          <Button color="green">Create Label</Button>
        </S.ButtonContainer>
      </S.LableInputRow>
    </S.LabelEditor>
  );
}
