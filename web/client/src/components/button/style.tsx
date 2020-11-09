import styled from "styled-components";

export const CustomButton = styled.button`
  display: flex;
  justify-content: center;
  align-items: center;
  border-radius: 6px;
  color: ${(props) => (props.color === "white" ? "black" : "white")};
  background-color: ${(porps) =>
    porps.color === "white" ? "#FAFBFC" : "#2ea44f"};
  width: max-content;
  height: 1.5rem;
  padding: 0.3rem 0.5rem;
  cursor: pointer;
  border: none;
  outline: none;
`;
