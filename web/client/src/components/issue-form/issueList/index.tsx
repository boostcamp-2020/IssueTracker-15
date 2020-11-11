import React, { useState, useEffect, Fragment } from "react";
import * as S from "./style";
import IssueComp from "./issueComp";
import { getIssues } from "../../../lib/api";
import useAsync from "../../../hooks/useAsync";

function IssueList() {
  const [issues, setIssues] = useState([]);

  // 맨 처음 opened issue 가져옴
  useEffect(() => {
    const fetchIssues = async () => {
      const newIssues = await getIssues(true);
      setIssues(newIssues);
    };
    fetchIssues();
  }, []);
  console.log(issues);
  return (
    <S.IssueList>
      {issues.map((issue: any) => {
        return <IssueComp info={issue} />;
      })}
    </S.IssueList>
  );
}

export default IssueList;
