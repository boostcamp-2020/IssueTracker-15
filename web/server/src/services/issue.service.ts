import { getRepository } from "typeorm";
import IssueEntity from "../entity/issue.entity";
import { CreateIssue } from "../types/issue.types";

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
};

export default IssueService;
