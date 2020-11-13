export default interface Milestone {
  openedIssueNum?: string;
  closedIssueNum?: string;
  id: number;
  title: string;
  description?: string;
  dueDate?: string;
}
