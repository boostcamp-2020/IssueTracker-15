import styled from 'styled-components';
import {Settings} from '@styled-icons/ionicons-sharp/Settings';

export const SettingIcon = styled(Settings)<{isHover: boolean}>`
  display: block;
  color: ${props => props.isHover ? '#5490E2' : 'grey'};

  width: 15px;
  height: 15px;
`;

export const ItemWrapper = styled.div`
  padding: 10px;


  width: 280px;
`;

export const ItemHead = styled.div`
  display: flex;
  justify-content: space-between;
  align-items: center;

  margin-bottom: 10px;

  box-sizing: border-box;
`;

export const MenuName = styled.div<{isHover: boolean}>`
  color: ${props => props.isHover ? '#5490E2' : '#555'};
  font-weight: 700;
`;

export const ItemBody = styled.div`
  padding-bottom: 20px;

  border-bottom : 1px solid #ccc;
`;
