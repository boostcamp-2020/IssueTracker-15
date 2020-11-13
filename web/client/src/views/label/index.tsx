import React, { Dispatch, SetStateAction, useState, useEffect } from "react";
import LabelRowContainer from "../../containers/label-row-container";
import LabelListHeader from "../../containers/label-list-header";
import Label from "../../@types/label-form";
import { getLabels } from "../../lib/api";
import useToggle from "../../hooks/useToggle";

export interface LabelsContextProps {
  labels: Label[];
  setLabels: Dispatch<SetStateAction<Label[]>>;
  editBoxToggle: number;
  setEditBoxToggle: Dispatch<SetStateAction<number>>;
}

export const LabelsContext = React.createContext({} as LabelsContextProps);

const LabelPage = () => {
  const [labels, setLabels] = useState([] as Label[]);
  const [editBoxToggle, setEditBoxToggle] = useState(0);

  const fetchInitialLabels = async () => {
    const labelList = await getLabels();
    setLabels(labelList);
  };

  useEffect(() => {
    fetchInitialLabels();
  }, []);

  return (
    <LabelsContext.Provider
      value={{ labels, setLabels, editBoxToggle, setEditBoxToggle }}
    >
      <LabelListHeader />
      <LabelRowContainer />
    </LabelsContext.Provider>
  );
};

export default LabelPage;
