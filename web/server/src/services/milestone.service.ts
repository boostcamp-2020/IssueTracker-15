import { getRepository, Repository, InsertResult } from "typeorm";
import MilestoneEntity from "../entity/milestone.entity";
import IssueEntity from "../entity/issue.entity";
import { Milestone } from "../types/milestone.types";

const MilestoneService = {
  getMilestones: async (): Promise<any> => {
    const issueRepository: Repository<IssueEntity> = getRepository(IssueEntity);
    /* const result = await issueRepository.query(
      `SELECT "milestoneId","isOpened", count(*) AS "productCount" FROM "product" WHERE "deleted" = false AND "isPublished" = false GROUP BY "releaseDate"`
    ); 

    console.log(result);
    return result; */
  },
  createMilestone: async (
    milestoneData: Milestone
  ): Promise<Record<string, number>> => {
    const milestoneRepository: Repository<MilestoneEntity> = getRepository(
      MilestoneEntity
    );
    const result = await milestoneRepository.insert(milestoneData);
    return result.identifiers[0];
  },

  deleteMilestone: async (milestoneId: number): Promise<void> => {
    const milestoneRepository: Repository<MilestoneEntity> = getRepository(
      MilestoneEntity
    );
    const milestoneToRemove:
      | MilestoneEntity
      | undefined = await milestoneRepository.findOne(milestoneId);
    if (!milestoneToRemove)
      throw new Error(`can't find milestone id ${milestoneId}`);
    await milestoneRepository.remove(milestoneToRemove);
  },

  updateMilestone: async (
    milestoneId: number,
    milestoneData: Milestone
  ): Promise<void> => {
    const milestoneRepository: Repository<MilestoneEntity> = getRepository(
      MilestoneEntity
    );
    const milestoneToUpdate:
      | MilestoneEntity
      | undefined = await milestoneRepository.findOne(milestoneId);
    if (!milestoneToUpdate)
      throw new Error(`can't find milestone id ${milestoneId}`);
    await milestoneRepository.update(milestoneToUpdate, milestoneData);
  },
};
export default MilestoneService;
