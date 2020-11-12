import React, { useState } from "react";
import CommentBox from "../../components/commentBox";
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
  const [textarea, setTextArea] = useState(comment ? comment.content : "");
  const onChangeTextArea = (e: React.ChangeEvent<HTMLTextAreaElement>) => {
    const value = e.target.value;
    setTextArea(value);
  };

  const [state, postComment] = useAsync(() => {
    return api.postComment({ userId: 3, issueId: 3, content: textarea });
  }, []);

  return (
    <CommentBox
      isAuthor={isAuthor}
      comment={comment}
      textArea={textarea}
      onChangeTextArea={onChangeTextArea}
    />
  );
}
