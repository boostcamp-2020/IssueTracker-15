import React, {
  ChangeEvent,
  Dispatch,
  SetStateAction,
  useContext,
  useCallback,
  useRef,
  useEffect,
} from "react";
import { LabelHeaderContext } from "../../containers/label-list-header";
import Button from "../button";
import * as S from "./style";
import { LabelsContext } from "../../views/label";
import { getRandomColor } from "../../lib/label-color";
import Label, { PostLabel } from "../../@types/label-form";
import { postNewLabel, patchUpdateLabel } from "../../lib/api";
interface LabelEditorProps {
  isCreate?: boolean;
  labelId?: number;
  labelContent?: string;
  setLabelContent?: Dispatch<SetStateAction<string>>;
  labelColor?: string;
  setLabelColor?: Dispatch<SetStateAction<string>>;
  newLabel: any;
  setNewLabel: Dispatch<SetStateAction<PostLabel>>;
}

export default function LabelEditor(props: LabelEditorProps) {
  const { setCreateLabel } = useContext(LabelHeaderContext);
  const { editBoxToggle, setEditBoxToggle } = useContext(LabelsContext);

  const { labels, setLabels } = useContext(LabelsContext);

  const labelNameInput = useRef(document.createElement("input"));
  const labelDescriptionInput = useRef(document.createElement("input"));
  const colorInput = useRef(document.createElement("input"));

  const onChangeNewLabel = (e: ChangeEvent<HTMLInputElement>) => {
    switch (e.currentTarget) {
      case labelNameInput.current:
        props.setNewLabel({ ...props.newLabel, title: e.currentTarget.value });
        break;
      case labelDescriptionInput.current:
        props.setNewLabel({
          ...props.newLabel,
          description: e.currentTarget.value,
        });
        break;
    }
  };

  const setInputDatas = () => {
    labelNameInput.current.value = props.newLabel.title
      ? props.newLabel.title
      : "";
    labelDescriptionInput.current.value = props.newLabel.description
      ? props.newLabel.description
      : "";
  };

  useEffect(() => {
    if (editBoxToggle) labelNameInput.current.focus();
    setInputDatas();
  }, [editBoxToggle]);

  const toggleCreateLabel = () => {
    if (setCreateLabel) {
      setCreateLabel(false);
    }
  };

  const resetInputs = () => {
    labelNameInput.current.value = "";
    labelDescriptionInput.current.value = "";
  };

  const updateLabel = async () => {
    if (!props.newLabel.id) return;
    const isSuccess = await patchUpdateLabel(props.newLabel);
    if (!isSuccess) alert("업데이트 실패");
    setLabels(
      labels.map((l) => {
        if (l.id === props.newLabel.id) {
          l = { ...(props.newLabel as Label) };
        }
        return l;
      })
    );
    setEditBoxToggle(0);
  };

  const createNewLabel = async () => {
    const newCreatedLabel = await postNewLabel(props.newLabel);
    if (!newCreatedLabel) {
      alert("라벨 생성 실패");
      return;
    }
    setLabels([...labels, newCreatedLabel]);
    toggleCreateLabel();
    resetInputs();
  };

  const changeLabelColor = () => {
    const newLabelColor = getRandomColor();
    colorInput.current.value = newLabelColor;
    props.setNewLabel({ ...props.newLabel, color: newLabelColor });
    if (props.setLabelColor) {
      props.setLabelColor(newLabelColor);
    }
  };

  const changeLabelContent = (e: React.ChangeEvent<HTMLInputElement>) => {
    onChangeNewLabel(e);
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
          <S.nameInput
            placeholder="Label name"
            onChange={changeLabelContent}
            ref={labelNameInput}
          />
          <S.descriptionInput
            placeholder="Description (optional)"
            onChange={onChangeNewLabel}
            ref={labelDescriptionInput}
          />
          <S.colorInputContainer>
            <S.IconContainer>
              <S.refreshIcon onClick={changeLabelColor} />
            </S.IconContainer>
            <S.colorInput
              defaultValue={props.labelColor ? props.labelColor : "#0052CD"}
              onChange={onChangeNewLabel}
              ref={colorInput}
            />
          </S.colorInputContainer>
        </S.inputContainer>
        <S.ButtonContainer>
          <Button
            color="white"
            onClick={props.isCreate ? toggleCreateLabel : toggleEditBox}
          >
            cancel
          </Button>
          <Button
            color="green"
            onClick={props.isCreate ? createNewLabel : updateLabel}
          >
            {props.isCreate ? "Create Label" : "Save Changes"}
          </Button>
        </S.ButtonContainer>
      </S.LableInputRow>
    </S.LabelEditor>
  );
}
