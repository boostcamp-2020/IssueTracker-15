import React from "react";
import * as S from "./style";

function TextArea() {
  return (
    <S.TextAreaWrapper>
      <S.StyledTextArea
        autoCapitalize="none"
        autoComplete="off"
        placeholder="leave a comment"
      />
      <S.AttachFileBox>Attach files by clicking here.</S.AttachFileBox>
    </S.TextAreaWrapper>
  );
}

export default TextArea;
