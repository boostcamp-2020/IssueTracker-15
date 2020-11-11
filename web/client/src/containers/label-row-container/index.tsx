import React, { Dispatch, SetStateAction, useEffect, useState } from "react";
import Label from "../../@types/label-form";
import LabelRow from "../../components/label-row";
import * as S from "./style";
import { getLabels } from "../../lib/api";

export interface LabelsContextProps {
  labels: Label[];
  setLabels: Dispatch<SetStateAction<Label[]>>;
}

export const LabelsContext = React.createContext({} as LabelsContextProps);

export default function LabelRowContainer() {
  const [labels, setLabels] = useState([] as Label[]);

  useEffect(() => {
    const initLabels = async () => {
      const labelList = await getLabels();
      setLabels(labelList);
    };
    initLabels();
  }, [labels]);

  return (
    <LabelsContext.Provider value={{ labels, setLabels }}>
      <S.LabelRowContainer>
        <S.LabelContainerHeader>{labels.length} Labels</S.LabelContainerHeader>
        {labels.map((label: Label) => {
          return <LabelRow key={label.id} label={label} />;
        })}
      </S.LabelRowContainer>
    </LabelsContext.Provider>
  );
}
