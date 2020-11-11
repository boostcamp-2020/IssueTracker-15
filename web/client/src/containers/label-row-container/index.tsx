import React, { useEffect, useState } from "react";
import LabelForm from "../../@types/label-form";
import LabelRow from "../../components/label-row";
import * as S from "./style";
import { getLabels } from "../../lib/api";

export default function LabelRowContainer() {
  const [labels, setLabels] = useState([]);

  useEffect(() => {
    const initLabels = async () => {
      const labelList = await getLabels();
      setLabels(labelList);
    };
    initLabels();
  }, [labels]);

  return (
    <S.LabelRowContainer>
      <S.LabelContainerHeader>{labels.length} Labels</S.LabelContainerHeader>
      {labels.map((label: LabelForm) => {
        return <LabelRow key={label.id} label={label} />;
      })}
    </S.LabelRowContainer>
  );
}
