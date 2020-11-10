import styled from 'styled-components';

export const CustomButton = styled.button`
  display: flex;
  justify-content: center;
  align-items: center;

  border-radius: 6px;
  color: ${(props) => (props.color === 'white' ? 'black' : 'white')};
  background-color: ${(porps) =>
    porps.color === 'white' ? '#FAFBFC' : '#2ea44f'};
  width: max-content;
  height: 1.5rem;
  padding: 0.9rem 1rem;
  cursor: pointer;
  border: ${(props) => (props.color === 'white' ? '1px solid #d8dbdb' : '0px')};
  outline: none;
`;
