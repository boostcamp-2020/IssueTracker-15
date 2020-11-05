import React from "react";
import * as S from "./style";

interface ButtonProps {
  value: string;
  color: string;
}
const Button: React.FC<ButtonProps> = ({ value, color }) => {
  return (
    <>
      <S.CustomButton color={color}>{value}</S.CustomButton>
    </>
  );
};

export default Button;
