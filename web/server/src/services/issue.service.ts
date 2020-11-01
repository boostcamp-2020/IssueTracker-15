import { getRepository } from "typeorm";
import AssigneesEntity from "../entity/assignees.entity";
import IssueHasLabelEntity from "../entity/issue-label.entity";
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

  addAssigneesToIssue: async (issueId: number, userId: number) => {
    const assigneesRepository = getRepository(AssigneesEntity);
    const newAssignees = assigneesRepository.create({
      issueId,
      userId,
    });
    await assigneesRepository.save(newAssignees);

    return;
  },

  addLabelToIssue: async (issueId: number, labelId: number) => {
    const issueHasLabelRepository = getRepository(IssueHasLabelEntity);
    const newIssueHasLabel = issueHasLabelRepository.create({
      issueId,
      labelId,
    });
    await issueHasLabelRepository.save(newIssueHasLabel);

    return;
  },

  deleteLabelAtIssue: async (issueId: number, labelId: number) => {
    const issueHasLabelRepository = getRepository(IssueHasLabelEntity);
    const issueHasLabel = issueHasLabelRepository.findOne({ issueId, labelId });
    if (!issueHasLabel) throw new Error("issueHasLabel dose not exist");
    await issueHasLabelRepository.delete({ issueId, labelId });

    return;
  },

  addMilestoneToIssue: async (issueId: number, milestoneId: number) => {
    const issueRepository = getRepository(IssueEntity);
    const issue = await IssueService.getIssueById(issueId);
    if (!issue) throw new Error("issue dose not exist");

    const updatedIssue = issueRepository.merge(issue, { milestoneId });
    await issueRepository.save(updatedIssue);

    return;
  },

  deleteMilestoneAtIssue: async (issueId: number) => {
    const issueRepository = getRepository(IssueEntity);
    const issue = await IssueService.getIssueById(issueId);
    if (!issue) throw new Error("issue dose not exist");

    await issueRepository.query(
      "UPDATE Issue SET milestoneId = ? WHERE id = ?",
      [null, issueId]
    );

    return;
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
