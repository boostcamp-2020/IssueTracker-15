import React from "react";
import * as S from "./style";

export interface LabelProps {
  name?: string;
  color: string;
}

export default function Label({ name, color }: LabelProps) {
  return (
    <>
      <S.Label color={color}>{name}</S.Label>
    </>
  );
}
