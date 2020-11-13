import styled from 'styled-components';

export const UserProfile =styled.img<{ size: number }>`
  display: block;
  border-radius: 100%;

  width: ${props => props.size}px;
  height: ${props => props.size}px;
`;