import React, { Fragment } from "react";
import styled from "styled-components";

const BtnAuth = styled.div`
  color: blue;
`;
interface BtnProps {
  btnName: string;
}
function Button<BtnProps>(props) {
  return <BtnAuth> {props.btnName} </BtnAuth>;
}

export default Button;
