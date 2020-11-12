import React from "react";
import * as S from "./style";

interface TextAreaProps {
  value: string;
  onChange: (event: React.ChangeEvent<HTMLTextAreaElement>) => void;
}

function TextArea({ value, onChange }: TextAreaProps) {
  return (
    <S.TextAreaWrapper>
      <S.StyledTextArea
        autoCapitalize="none"
        autoComplete="off"
        placeholder="leave a comment"
        value={value}
        onChange={onChange}
      />
      <S.AttachFileBox>Attach files by clicking here.</S.AttachFileBox>
    </S.TextAreaWrapper>
  );
}

export default TextArea;
