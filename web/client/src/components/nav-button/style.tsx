import styled from "styled-components";

interface Container {
  width: string;
}
export const NavButton = styled.div<Container>`
  width: ${(props) => props.width};
  display: flex;
  align-contents: center;
  padding: 1%;
  color: #586069;
  border-radius: 6px;
  background-color: #fafbfc;
  border: 1px solid #ced4da;
`;

export const NavButtonTitle = styled.div`
  margin-left: 3%;
  text-align: center;
  font-weight: bolder;
`;
