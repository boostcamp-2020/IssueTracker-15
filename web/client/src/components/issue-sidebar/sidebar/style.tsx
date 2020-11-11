import styled from "styled-components";
import { Label } from "../../label/style";

export const AssigneeProfileWrapper = styled.div`
  display: flex;
  align-items: center;

  margin-bottom: 7px;
`;

export const AssigneeName = styled.div`
  margin-left: 10px;

  font-weight: 700;
  color: #333;
`;

export const LabelWrapper = styled.div<{ color: string }>`
  padding: 6px 5px;

  border-radius: 6px;

  background: ${(props) => props.color};

  font-weight: 700;

  box-sizing: border-box;
`;

export const LabelsWrapper = styled.div`
  display: flex;
  flex-wrap: wrap;
`;

export const MarginLabel = styled(Label)`
  margin-right: 8px;
`;
