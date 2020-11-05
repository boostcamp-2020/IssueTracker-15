import React, { Fragment } from "react";
import styled from "styled-components";

const TitleInputWrapAuth = styled.div`
  padding-top: 2%;
  padding-bottom: 0.5%;
  display: flex;
  flex-direction: column;
`;

interface TitleProps {
  title: string;
}
function InputTitle<TitleProps>(props) {
  return <TitleInputWrapAuth>{props.title}</TitleInputWrapAuth>;
}

export default InputTitle;
