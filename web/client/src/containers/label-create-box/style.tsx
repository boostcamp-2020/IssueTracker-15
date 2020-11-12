import styled from "styled-components";
import { LabelContextProps } from "../label-list-header";

export const LabelCreateBox = styled.div`
  display: ${(props: LabelContextProps) =>
    props.createLabelVisible ? "flex" : "none"};
  flex-direction: column;
  justify-content: center;
  align-items: flex-start;
  padding: 0.5rem 1rem;
  width: 65%;
  background-color: rgb(245, 248, 250);
  border: 1px solid #e8e8e8;
  margin-top: 0.5rem;
`;

export const LabelContainerRow = styled.div`
  display: flex;
  justify-content: flex-start;
  align-items: center;
  width: 100%;
  padding: 0.5rem 0rem;
`;
