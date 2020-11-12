import styled from "styled-components";

export const LabelRowContainer = styled.div`
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  align-items: center;
  width: 65%;
`;
export const LabelRow = styled.div`
  display: flex;
  flex-direction: row;
  justify-content: space-between;
  align-items: center;
  width: 100%;
  padding: 0.7rem 1rem;
  border-left: 1px solid #e8e8e8;
  border-right: 1px solid #e8e8e8;
  border-bottom: 1px solid #e8e8e8;
`;

export const LabelContainer = styled.div`
  display: flex;
  justify-content: flex-start;
  align-items: center;
  width: 25%;
`;

export const LabelDescription = styled.div`
  display: flex;
  justify-content: flex-start;
  align-items: center;
  width: 45%;
  font-size: small;
`;

export const LabelControllButtonContainer = styled.div`
  display: flex;
  justify-content: flex-end;
  align-items: center;
  width: 15%;
  font-size: small;
`;

export const LabelControllbutton = styled.div`
  display: flex;
  justify-content: center;
  align-items: center;
  margin: 0rem 0.5rem;
  cursor: pointer;
`;
