import React, { useCallback, useState } from "react";
import * as S from "./style";
import Button from "../../components/button";
import LabelCreateBox from "../../components/label-create-box";

export default function LabelListHeader() {
  const [createLabelVisible, setCreateLabel] = useState(false);

  const toggleCreateLabel = useCallback(() => {
    setCreateLabel(!createLabelVisible);
  }, [createLabelVisible]);

  return (
    <S.LabelListHeaderWrapper>
      <S.LabelListHeader>
        <Button value="New Label" color="green" onClick={toggleCreateLabel} />
      </S.LabelListHeader>
      <LabelCreateBox visible={createLabelVisible} />
    </S.LabelListHeaderWrapper>
  );
}
