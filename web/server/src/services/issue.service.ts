import { getRepository } from "typeorm";
import AssigneesEntity from "../entity/assignees.entity";
import IssueHasLabelEntity from "../entity/issue-label.entity";
import IssueEntity from "../entity/issue.entity";
import {
  CreateIssue,
  UpdateIssueContent,
  UpdateIssueTitle,
} from "../types/issue";

const IssueService = {
  createIssue: async (issueData: CreateIssue): Promise<IssueEntity> => {
    const issueRepository = getRepository(IssueEntity);
    const issue: IssueEntity = await issueRepository.create(issueData);
    const newIssue: IssueEntity = await issueRepository.save(issue);

    return newIssue;
  },

  getIssues: async () => {
    const issueRepository = getRepository(IssueEntity);
    const issues: IssueEntity[] = await issueRepository.find();

    return issues;
  },

  getIssuesByCount: async (count: number) => {
    const issueRepository = getRepository(IssueEntity);
    const issues: IssueEntity[] = await issueRepository.find({
      take: 10,
      skip: 5,
    });

    return issues;
  },

  getIssueOverAllCount: async () => {
    const issueRepository = getRepository(IssueEntity);
    const openedIssueCount: Object[] = await issueRepository.query(
      `SELECT COUNT(*) as opendIssueCount FROM Issue where isOpened = 1`
    );
    const closedIssueCount: Object[] = await issueRepository.query(
      `SELECT COUNT(*) as closedIssueCount FROM Issue where isOpened = 0`
    );

    const issueCount = { ...openedIssueCount[0], ...closedIssueCount[0] };
    return issueCount;
  },

  getDetailIssueById: async (issueId: number) => {
    const issueRepository = getRepository(IssueEntity);
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

  deleteAssigneesToIssue: async (issueId: number, userId: number) => {
    const assigneesRepository = getRepository(AssigneesEntity);
    const assignees = await assigneesRepository.findOne({
      where: { issueId, userId },
    });
    if (!assignees) throw new Error("assignees does not exists");
    await assigneesRepository.delete({ issueId, userId });

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
    const issueToUpdate = await IssueService.getIssueById(issueId);
    if (!issueToUpdate) throw new Error("issue dose not exist");

    await issueRepository.update(issueToUpdate, content);

    return;
  },

  updateIssueTitle: async (issueId: number, title: UpdateIssueTitle) => {
    const issueRepository = getRepository(IssueEntity);
    const issueToUpdate = await IssueService.getIssueById(issueId);

    if (!issueToUpdate) throw new Error("issue dose not exist");

    await issueRepository.update(issueToUpdate, title);

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
