import { getRepository, Repository } from 'typeorm';
import MilestoneEntity from '../entity/milestone.entity';
import { Milestone } from '../types/milestone.types';

const MilestoneService = {
  getMilestones: async (): Promise<Record<string, string>> => {
    const milestoneRepository: Repository<MilestoneEntity> = getRepository(
      MilestoneEntity
    );
    const newMilestones = await milestoneRepository.query(
      `SELECT count(if(Issue.isOpened,1,null)) as openedIssueNum,count(if(Issue.isOpened=0,1,null)) as closedIssueNum,  Milestone.* FROM Issue RIGHT OUTER JOIN Milestone ON Issue.milestoneId=Milestone.id group by Milestone.id`
    );
    return newMilestones;
  },

  getMilestonesById: async (id: number): Promise<MilestoneEntity | null> => {
    const milestoneRepository: Repository<MilestoneEntity> = getRepository(
      MilestoneEntity
    );

    const [milestone] = (await milestoneRepository.query(
      `SELECT count(if(Issue.isOpened,1,null)) as openedIssueNum,count(if(Issue.isOpened=0,1,null)) as closedIssueNum,  Milestone.* FROM Issue RIGHT OUTER JOIN Milestone ON Issue.milestoneId=Milestone.id where Milestone.id=${id}`
    )) as MilestoneEntity[];

    if (!milestone) return null;

    return milestone;
  },
  createMilestone: async (milestoneData: Milestone): Promise<any> => {
    const milestoneRepository: Repository<MilestoneEntity> = getRepository(
      MilestoneEntity
    );
    const milestone: MilestoneEntity = await milestoneRepository.create(
      milestoneData
    );
    const newMilestone: MilestoneEntity = await milestoneRepository.save(
      milestone
    );

    return { openedIssueNum: '0', closedIssueNum: '0', ...newMilestone };
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
    await milestoneRepository.delete(milestoneToRemove.id);
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
