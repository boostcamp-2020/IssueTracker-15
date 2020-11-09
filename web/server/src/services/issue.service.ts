import { getRepository } from "typeorm";
import AssigneesEntity from "../entity/assignees.entity";
import IssueHasLabelEntity from "../entity/issue-label.entity";
import IssueEntity from "../entity/issue.entity";
import {
  makeIssuesTemplate,
  makeIssueTemplate,
} from "../lib/make-issue-template";
import { CreateIssue, UpdateIssue } from "../types/issue";

const IssueService = {
  createIssue: async (issueData: CreateIssue): Promise<IssueEntity> => {
    const issueRepository = getRepository(IssueEntity);
    const issue: IssueEntity = await issueRepository.create(issueData);
    const newIssue: IssueEntity = await issueRepository.save(issue);

    return newIssue;
  },

  getIssues: async (isOpened: boolean) => {
    const issueRepository = getRepository(IssueEntity);
    const issueList: IssueEntity[] = await issueRepository
      .createQueryBuilder("Issue")
      .leftJoin("Issue.milestone", "Milestone")
      .innerJoin("Issue.author", "User")
      .where("Issue.isOpened = :isOpened", { isOpened })
      .select([
        "Issue.id",
        "Issue.title",
        "Issue.createAt",
        "Issue.updateAt",
        "Issue.isOpened",
        "Issue.milestoneId",
        "User.userName",
        "Milestone.title",
      ])
      .getMany();

    const issues = await makeIssuesTemplate(issueList);

    return issues;
  },

  getDetailIssueById: async (issueId: number) => {
    const issueRepository = getRepository(IssueEntity);
    const issue = (await issueRepository
      .createQueryBuilder("Issue")
      .leftJoin("Issue.milestone", "Milestone")
      .innerJoin("Issue.author", "User")
      .where("Issue.id = :issueId", { issueId })
      .select([
        "Issue.id",
        "Issue.title",
        "Issue.description",
        "Issue.createAt",
        "Issue.updateAt",
        "Issue.isOpened",
        "User.userName",
        "User.imageURL",
        "Milestone.id",
        "Milestone.title",
      ])
      .getOne()) as IssueEntity;

    if (!issue) throw new Error("issue does not exists");

    const detailIssue = await makeIssueTemplate(issue);

    return detailIssue;
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

  updateIssueContent: async (issueId: number, body: UpdateIssue) => {
    const issueRepository = getRepository(IssueEntity);
    const issueToUpdate = await IssueService.getIssueById(issueId);
    if (!issueToUpdate) throw new Error("issue dose not exist");
    await issueRepository.update({ id: issueId }, body);

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
