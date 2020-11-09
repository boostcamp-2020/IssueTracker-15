import styled from "styled-components";
import { Refresh } from "@styled-icons/boxicons-regular/Refresh";

export const LabelEditor = styled.div`
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  width: 100%;
  overflow: hidden;
`;

export const LabelTitleRow = styled.div`
  display: flex;
  flex-direction: row;
  justify-content: flex-start;
  align-items: center;
  width: 100%;
  padding: 0.3rem 1rem 0.5rem 1.5rem;
  font-size: 0.8rem;
  font-weight: bold;
`;

export const LableInputRow = styled.div`
  display: flex;
  flex-direction: row;
  justify-content: space-between;
  align-items: center;
  width: 100%;
  padding: 0rem 1rem 0.3rem 1.5rem;
`;

export const nameTitle = styled.div`
  display: flex;
  justify-content: flex-start;
  align-items: center;
  width: 11rem;
`;
export const descriptionTitle = styled.div`
  display: flex;
  justify-content: flex-start;
  align-items: center;
  width: 16rem;
`;
export const colorTitle = styled.div`
  display: flex;
  justify-content: flex-start;
  align-items: center;
`;

export const inputContainer = styled.div`
  display: flex;
  justify-content: flex-start;
  align-items: center;
`;
export const nameInput = styled.input`
  display: flex;
  justify-content: flex-start;
  align-items: center;
  width: 8rem;
  margin-right: 2.5rem;
`;
export const descriptionInput = styled.input`
  display: flex;
  justify-content: flex-start;
  align-items: center;
  width: 13rem;
  margin-right: 2.5rem;
`;

export const colorInputContainer = styled.div`
  display: flex;
  flex-direction: row;
  justify-content: flex-start;
  align-items: center;
`;

export const IconContainer = styled.div`
  display: flex;
  justify-content: flex-start;
  align-items: center;
  border-radius: 5px;
  border: 1px solid #e8e8e8;
  background-color: #0052cd;
  cursor: pointer;
  margin-right: 0.5rem;
`;

export const refreshIcon = styled(Refresh)`
  display: flex;
  color: white;
  width: 1.5rem;
  height: 1.5rem;
`;

export const colorInput = styled.input`
  display: flex;
  justify-content: flex-start;
  align-items: center;
  width: 5rem;
  margin-right: 1rem;
`;

export const ButtonContainer = styled.div`
  display: flex;
  flex-direction: row;
  justify-content: flex-end;
  align-items: center;
  width: 11rem;
  padding-right: 1rem;
`;
