import React, { useState, useEffect, Fragment } from "react";
import * as S from "./style";
import IssueComp from "./issueComp";
import { getIssues } from "../../../lib/api";
import useAsync from "../../../hooks/useAsync";

function IssueList() {
  const [issues, setIssues] = useState([]);

  useEffect(() => {
    const fetchIssues = async () => {
      const newIssues = await getIssues(true);
      setIssues(newIssues);
    };
    fetchIssues();
  }, []);

  return (
    <S.IssueList>
      <IssueComp />
      <IssueComp />
    </S.IssueList>
  );
}

export default IssueList;
