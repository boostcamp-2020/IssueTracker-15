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
};
export default MilestoneService;
