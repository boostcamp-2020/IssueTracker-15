import styled from "styled-components";

export const Label = styled.div`
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  background-color: ${(props) => props.color};
  width: max-content;
  padding: 5px 8px;
  border-radius: 9px;
`;
