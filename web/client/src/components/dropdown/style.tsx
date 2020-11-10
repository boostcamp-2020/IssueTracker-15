import styled from "styled-components";

export const DropdownContent = styled.li`
  color: #63666a;
  padding-top: 2.5%;
  padding-bottom: 2.5%;
  padding-left: 5%;
  padding-right: 5%;
  list-style: none;
  border-bottom: 1px solid #ced4da;
`;

export const DropdownTitle = styled.div`
  font-weight: bold;
  background-color: #f6f8fa;
  padding-top: 2.5%;
  padding-bottom: 2.5%;
  padding-left: 5%;
  padding-right: 5%;
  border-bottom: 1px solid #ced4da;
`;
interface displayProps {
  isVisible: boolean;
}

export const DropdownWrapper = styled.div<displayProps>`
  position: absolute;
  border: 1px solid #ced4da;
  width: 300px;
  margin-top: 12%;
  border-radius: 6px;
  left: 0;
  display: ${(props) => (props.isVisible ? "block" : "none")};
`;

export const ListWrapper = styled.ul`
  padding: 0;
  margin-top: 0;
  margin-bottom: 0;
`;
