import IssueEntity from "../entity/issue.entity";
import CommentService from "../services/comment.service";
import LabelService from "../services/label.service";
import UserService from "../services/user.service";

const makeIssuesTemplate = async (issueList: IssueEntity[]) => {
  const detailIssues = await Promise.all(
    issueList.map(async (issue) => {
      const labels = await LabelService.getLabelsByIssueId(issue.id);
      const assignees = await UserService.getAssigneeList(issue.id);
      return { ...issue, labels, assignees };
    })
  );

  return detailIssues;
};

const makeIssueTemplate = async (issue: IssueEntity) => {
  const labels = await LabelService.getLabelsByIssueId(issue.id);
  const assignees = await UserService.getAssigneeList(issue.id);
  const comments = await CommentService.getCommentsByIssueId(issue.id);
  const detailIssue = {
    ...issue,
    labels,
    assignees,
    comments,
  };

  return detailIssue;
};

export { makeIssueTemplate, makeIssuesTemplate };
