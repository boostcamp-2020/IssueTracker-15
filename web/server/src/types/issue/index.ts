import CreateIssue from "./create-issue";
import UpdateIssueTitle from "./update-issue-title";
import UpdateIssueContent from "./udpate-issue-content";
import IssueHasLabelEntity from "../../entity/issue-label.entity";

interface DetailIssue {
  id: number;
  title: string;
  createAt: Date;
  milestoneId: number | undefined;
  milestone?: {
    title: string;
  };
  author: {
    userName: string;
  };
  labels?: IssueHasLabelEntity[];
  assignees: any;
}

export { CreateIssue, UpdateIssueTitle, UpdateIssueContent, DetailIssue };
