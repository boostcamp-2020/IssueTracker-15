import React, { useEffect, useState } from "react";
import LabelForm from "../../@types/label-form";
import LabelRow from "../../components/label-row";
import * as S from "./style";

export default function LabelRowContainer() {
  const [labels, setLabels] = useState([]);

  useEffect(() => {
    const getLabels = async () => {
      const result = await fetch("http://118.67.134.194:3000/api/label", {
        method: "GET",
      });
      if (!result.ok) return;

      const labelList = await result.json();

      setLabels(labelList);
    };
    getLabels();
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
