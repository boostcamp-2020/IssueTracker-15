import React, { Fragment } from "react";
import styled from "styled-components";
import InputTitle from "./input-title";

const InputWrap = styled.div`
  padding-top: 1%;
  padding-bottom: 1%;
  display: flex;
  flex-direction: column;
  margin-top: 2%;
  margin-bottom: 2%;
`;

const InputBox = styled.input`
  width: 98%;
  padding-top: 5%;
  padding-bottom: 5%;
  border: 1px solid #ced4da;
`;
interface InputProps {
  title: string;
  name: string;
}
function Input<InputProps>(props) {
  return (
    <InputWrap>
      <InputTitle title={props.title} />
      <InputBox type="text" name={props.name} autoComplete="off" />
    </InputWrap>
  );
}

export default Input;
