import styled from "styled-components";

export const CustomButton = styled.div`
  display: flex;
  justify-content: center;
  align-items: center;

  border-radius: 6px;
  color: ${(props) => (props.color === "white" ? "black" : "white")};
  background-color: ${(porps) =>
    porps.color === "white" ? "white" : "#2ea44f"};
  width: 3rem;
  height: 1.5rem;
  padding: 0.3rem 0.5rem;

  :hover {
    cursor: pointer;
  }
`;
