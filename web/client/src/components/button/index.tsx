import React from "react";
import * as S from "./style";

interface ButtonProps {
  value: string;
  color: string;
}
export default function Button({ value, color }: ButtonProps) {
  return (
    <>
      <S.CustomButton color={color}>{value}</S.CustomButton>
    </>
  );
}
