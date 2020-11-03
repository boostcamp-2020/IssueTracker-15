import IssueEntity from "../entity/issue.entity";
import LabelService from "../services/label.service";
import UserService from "../services/user.service";
import { DetailIssue } from "../types/issue";

const makeIssueTemplate = async (issueList: IssueEntity[]) => {
  const detailIssue = [];
  for (const issue of issueList) {
    const labelList = await LabelService.getLabelsByIssueId(issue.id);
    const assigneeList = await UserService.getAssigneeList(issue.id);
    detailIssue.push({ ...issue, labels: labelList, assignees: assigneeList });
  }

  return detailIssue;
};

export default makeIssueTemplate;
