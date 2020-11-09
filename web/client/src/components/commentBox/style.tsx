import styled from 'styled-components';
import Palette from '../../../assets/palette';

const { color } = Palette;

export const CommentBoxWrapper = styled.div`
  margin-left: 15px;

  min-width: 500px;
`;

export const CommentBoxTitle = styled.div<{ isAuthor: boolean }>`
  position: relative;
  display: flex;
  justify-content: space-between;
  align-items:center;

  padding: 13px 20px;

  height: 25px;

  background: ${(props) =>
    props.isAuthor ? color.commentTitleByAuthor : color.commentTitleByUser};
  border: 1px solid
    ${(props) =>
      props.isAuthor
        ? color.commentBoxBorderByAuthor
        : color.commentBoxBorderByUser};
  border-radius: 5px 5px 0 0;

  &:after,
  :before {
    right: 100%;
    top: 50%;
    border: solid transparent;
    content: '';
    height: 0;
    width: 0;
    position: absolute;
    pointer-events: none;
  }

  &:after {
    border-color: transparent;
    border-right-color: ${(props) =>
      props.isAuthor ? color.commentTitleByAuthor : color.commentTitleByUser};
    border-width: 7px;
    margin-top: -7px;
  }

  &:before {
    border-color: transparent;
    border-right-color: ${(props) =>
      props.isAuthor
        ? color.commentBoxBorderByAuthor
        : color.commentBoxBorderByUser};
    border-width: 8px;
    margin-top: -8px;
  }
`;

export const TitleLeft = styled.div`
  display: flex;
  align-items: center;
`;

export const UserID = styled.span`
  display: block;
  font-weight: 700;
`;

export const WriteTime = styled.div`
  margin-left: 10px;
  color: #656c76;
`;

export const TitleRight = styled.div<{ isAuthor: boolean }>`
  display: ${(props) => (props.isAuthor ? 'flex' : 'none')};
  align-items: center;
`;

export const UserBox = styled.div`
  padding: 2px 5px;

  border: 1px solid #ccc;
  border-radius: 3px;

  box-sizing: border-box;

  color: #555;
  font-weight: 700;
`;

export const Edit = styled.div`
  margin-left: 10px;
  color: #656c76;

  cursor: pointer;
`;

export const CommentBoxBody = styled.div<{ isAuthor: boolean }>`
  padding: 16px 20px;

  border: 1px solid
    ${(props) =>
      props.isAuthor
        ? color.commentBoxBorderByAuthor
        : color.commentBoxBorderByUser};
  border-top-color: transparent;
  border-radius: 0 0 5px 5px;

  line-height: 1.3;
`;

export const CommentWithProfileWrapper = styled.div`
  display:flex;
`;

export const ProfilePhotoWrapper = styled.div`
  padding-top: 10px;

  box-sizing:border-box;
`;
