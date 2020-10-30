import { getRepository } from "typeorm";
import IssueEntity from "../entity/issue.entity";
import { createIssue } from "../types/issue.types";

const IssueService = {
  createIssue: async (issueData: createIssue): Promise<IssueEntity> => {
    const issueRepository = getRepository(IssueEntity);
    const issue: IssueEntity = await issueRepository.create(issueData);
    const results: IssueEntity = await issueRepository.save(issue);
    return results;
  },
};

export default IssueService;
