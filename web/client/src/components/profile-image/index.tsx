import React from "react";
import * as S from "./style";

interface ProfileImageProps {
  img: string | null;
  size: number;
}
export default function ProfileImage({ img, size }: ProfileImageProps) {
  return (
    <>
      <S.UserProfile
        src={!img ? "https://i.stack.imgur.com/frlIf.png" : img}
        alt="user-profile"
        size={size}
      />
    </>
  );
}
