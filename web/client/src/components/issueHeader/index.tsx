import React from 'react';

import * as S from './style';
import { getTimeTillNow } from '../../lib/dateParser';
import Button from '../button';

interface IssueProps {
  title: string;
  id: number;
  author: {
    userName: string;
  };
  createAt: string;
  commentLength: number;
}
export default function IssueHeader({
  title,
  id,
  author,
  createAt,
  commentLength,
}: IssueProps) {
  return (
    <S.IssueHeaderWrapper>
      <S.IssueTitleNumberButtonWrapper>
        <S.IssueTitleNumberWrapper>
          <S.IssueTitle>{title}</S.IssueTitle>
          <S.IssueNumber>#{id}</S.IssueNumber>
        </S.IssueTitleNumberWrapper>

        <Button color="white">Edit</Button>
      </S.IssueTitleNumberButtonWrapper>

      <S.IssueInfoWrapper>
        <Button color="green">Open</Button>
        <S.IssueInfoText>
          <S.UserName>{`${author.userName}`}&nbsp;</S.UserName>
          {` opened this issue ${getTimeTillNow(
            createAt
          )} ago · ${commentLength} comments`}
        </S.IssueInfoText>
      </S.IssueInfoWrapper>
    </S.IssueHeaderWrapper>
  );
}
