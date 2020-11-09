import React from "react";
import * as S from "./style";
import Button from "../../components/button";
import LabelEditor from "../../components/label-editor";
import LabelCreateBox from "../../components/label-create-box";
export default function LabelListHeader() {
  return (
    <S.LabelListHeaderWrapper>
      <S.LabelListHeader>
        <Button value="New Label" color="green" />
      </S.LabelListHeader>
      <LabelCreateBox />
    </S.LabelListHeaderWrapper>
  );
}
