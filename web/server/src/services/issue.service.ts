import { getRepository } from "typeorm";
import IssueEntity from "../entity/issue.entity";
import { CreateIssue, UpdateIssueTitle } from "../types/issue.types";

const IssueService = {
  createIssue: async (issueData: CreateIssue): Promise<IssueEntity> => {
    const issueRepository = getRepository(IssueEntity);
    const issue: IssueEntity = await issueRepository.create(issueData);
    const results: IssueEntity = await issueRepository.save(issue);
    return results;
  },

  getIssues: async () => {
    const issueRepository = getRepository(IssueEntity);
    const issues: IssueEntity[] = await issueRepository.find();

    return issues;
  },

  updateIssue: async (issueId: number, title: UpdateIssueTitle) => {
    const issueRepository = getRepository(IssueEntity);
    const issue = await issueRepository.findOne({ where: { id: issueId } });

    if (!issue) throw new Error("issue dose not exist ");

    const newIssue = issueRepository.merge(issue, title);
    await issueRepository.save(newIssue);

    return;
  },
};

export default IssueService;
