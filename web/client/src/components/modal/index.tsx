import React from "react";
import styled from "styled-components";
const BoxForm = styled.div`
  position: absolute;
  height: 45%;
  width: 30%;
  top: 40%;
  left: 50%;
  padding: 2%;
  z-index: 1;
  background-color: white;
  transform: translate(-50%, -50%);
  box-shadow: rgba(0, 0, 0, 0.5) 0 0 0 9999px,
    rgba(0, 0, 0, 0.5) 2px 2px 3px 3px;
`;
function Auth(props) {
  return <BoxForm>{props.children}</BoxForm>;
}
export default Auth;
