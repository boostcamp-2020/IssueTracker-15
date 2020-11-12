import styled from "styled-components";

export const PageGrid = styled.div`
  width: 1280px;
  margin: 0 auto;
`;
export const ColumnWrapper = styled.div`
  display: flex;
  justify-content: space-between;
`;
export const LeftColumn = styled.div`
  flex-grow: 0.8;
  flex-shrink: 0;
`;

export const RightColumn = styled.div`
  flex-shrink: 0;
`;
