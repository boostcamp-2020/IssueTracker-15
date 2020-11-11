import React from 'react';
import * as S from './style';

interface ButtonProps {
  children: React.ReactNode;
  color: string;
  onClick?: () => void;
}
export default function Button({ children, color, onClick }: ButtonProps) {
  return (
    <S.CustomButton color={color} onClick={onClick}>
      {children}
    </S.CustomButton>
  );
}
