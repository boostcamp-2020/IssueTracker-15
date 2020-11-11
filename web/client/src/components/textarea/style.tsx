import styled from "styled-components";

export const TextAreaWrapper = styled.div`
  box-shadow: inset 0 1px 0 rgba(225, 228, 232, 0.2);
`;

export const StyledTextArea = styled.textarea`
  display: block;
  padding: 10px;

  width: 100%;
  height: 10rem;

  resize: none;

  outline: none;

  border-radius: 5px 5px 0 0;
  border: 1px solid #bbb;
  border-bottom: none;

  box-sizing: border-box;

  background-color: #fafbfc;
`;

export const AttachFileBox = styled.div`
  padding: 10px;

  outline: none;

  border-radius: 0 0 5px 5px;
  border: 1px solid #bbb;
  border-top: 1px dashed #bbb;

  box-sizing: border-box;

  background-color: #fff;

  color: #24292e;
  font-size: 0.8rem;

  cursor: pointer;
`;
