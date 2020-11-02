import { getRepository, Repository } from "typeorm";
import MilestoneEntity from "../entity/milestone.entity";
import { Milestone } from "../types/milestone.types";

const MilestoneService = {
  createMilestone: async (milestoneData: Milestone): Promise<void> => {
    const milestoneRepository: Repository<MilestoneEntity> = getRepository(
      MilestoneEntity
    );
    await milestoneRepository.insert(milestoneData);
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
};
export default MilestoneService;
