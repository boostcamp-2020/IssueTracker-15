import { getRepository, Repository } from "typeorm";
import MilestoneEntity from "../entity/milestone.entity";
import { createMilestone } from "../types/milestone.types";

const MilestoneService = {
  createMilestone: async (milestoneData: createMilestone): Promise<void> => {
    const milestoneRepository: Repository<MilestoneEntity> = getRepository(
      MilestoneEntity
    );
    const milestone: MilestoneEntity = await milestoneRepository.create(
      milestoneData
    );
    await milestoneRepository.save(milestone);
  },
};
export default MilestoneService;
