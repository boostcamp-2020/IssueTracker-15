export default interface IssueProp {
  id: number;
  title: string;
  createAt: string;
  updateAt: string;
  isOpened: boolean;
  milestoneId: number | null;
  milestone: { title: string } | null;
  author: { id: number; userName: string };
  labels: { id: number; title: string; description: string; color: string }[];
  assignees: { id: number; userName: string; imgURL: string }[];
}
