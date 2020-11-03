import IssueEntity from "../entity/issue.entity";
import CommentService from "../services/comment.service";
import LabelService from "../services/label.service";
import UserService from "../services/user.service";

const makeIssuesTemplate = async (issueList: IssueEntity[]) => {
  const detailIssues = [];
  for (const issue of issueList) {
    const labelList = await LabelService.getLabelsByIssueId(issue.id);
    const assigneeList = await UserService.getAssigneeList(issue.id);
    detailIssues.push({ ...issue, labels: labelList, assignees: assigneeList });
  }

  return detailIssues;
};

const makeIssueTemplate = async (issue: IssueEntity) => {
  const labelList = await LabelService.getLabelsByIssueId(issue.id);
  const assigneeList = await UserService.getAssigneeList(issue.id);
  const comments = await CommentService.getCommentsByIssueId(issue.id);
  const detailIssue = {
    ...issue,
    labels: labelList,
    assignees: assigneeList,
    comments,
  };

  return detailIssue;
};

export { makeIssueTemplate, makeIssuesTemplate };
