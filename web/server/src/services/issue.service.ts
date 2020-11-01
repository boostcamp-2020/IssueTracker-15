import { getRepository } from "typeorm";
import IssueEntity from "../entity/issue.entity";
import {
  CreateIssue,
  UpdateIssueContent,
  UpdateIssueTitle,
} from "../types/issue.types";

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

  getIssueById: async (issueId: number) => {
    const issueRepository = getRepository(IssueEntity);
    const issue = await issueRepository.findOne({ where: { id: issueId } });

    return issue;
  },

  updateIssueContent: async (issueId: number, content: UpdateIssueContent) => {
    const issueRepository = getRepository(IssueEntity);
    const issue = await IssueService.getIssueById(issueId);
    if (!issue) throw new Error("issue dose not exist");

    const updatedIssue = issueRepository.merge(issue, content);
    await issueRepository.save(updatedIssue);

    return;
  },

  updateIssueTitle: async (issueId: number, title: UpdateIssueTitle) => {
    const issueRepository = getRepository(IssueEntity);
    const issue = await IssueService.getIssueById(issueId);

    if (!issue) throw new Error("issue dose not exist");

    const updatedIssue = issueRepository.merge(issue, title);
    await issueRepository.save(updatedIssue);

    return;
  },

  deleteIssue: async (issueId: number) => {
    const issueRepository = getRepository(IssueEntity);
    const issue = await IssueService.getIssueById(issueId);
    if (!issue) throw new Error("issue dose not exist");

    await issueRepository.delete({ id: issueId });

    return;
  },
};

export default IssueService;
