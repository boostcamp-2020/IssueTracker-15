import React, { useEffect, useState } from "react";
import CommentBox from "../../components/commentBox";
import {
  useIssueDetailDispatch,
  useIssueDetailState,
} from "../../contexts/issueDetailContext";
import useAsync from "../../hooks/useAsync";
import * as api from "../../lib/api";

interface CommentBoxContainerPropsType {
  isAuthor: boolean;
  comment?: {
    id: number;
    createAt: string;
    content: string;
    user: {
      userName: string;
      imageURL: string;
    };
  } | null;
}

export default function CommentBoxContainer({
  isAuthor,
  comment = null,
}: CommentBoxContainerPropsType) {
  const issueDetail = useIssueDetailState();
  const issueDetailDispatch = useIssueDetailDispatch();

  const [textarea, setTextArea] = useState(comment ? comment.content : "");
  const onChangeTextArea = (e: React.ChangeEvent<HTMLTextAreaElement>) => {
    const value = e.target.value;
    setTextArea(value);
  };

  const { id, isOpened } = useIssueDetailState().issue.data;

  return (
    <>
      <CommentBox
        isAuthor={isAuthor}
        comment={comment}
        textArea={textarea}
        onChangeTextArea={onChangeTextArea}
        issueId={id}
        isIssueOpened={isOpened}
        closeIssue={() => api.closeIssue(id)}
      />
    </>
  );
}
