import React from "react";
import * as S from "./style";

interface ButtonProps {
  value: string;
  color: string;
  onClick?: () => void;
}
export default function Button({ value, color, onClick }: ButtonProps) {
  return (
    <S.CustomButton color={color} onClick={onClick}>
      {value}
    </S.CustomButton>
  );
}
