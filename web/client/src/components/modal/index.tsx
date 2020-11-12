import React from "react";
import * as S from "./style";

function Auth(props: { children: React.ReactNode }) {
  return <S.BoxForm>{props.children}</S.BoxForm>;
}
export default Auth;
