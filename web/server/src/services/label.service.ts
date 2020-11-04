import { getRepository } from "typeorm";
import { Label, LabelUpdateToFix } from "../types/label.type";
import LabelEntity from "../entity/label.entity";
import IssueHasLabelEntity from "../entity/issue-label.entity";

const LabelService = {
  create: async (labelData: Label): Promise<LabelEntity> => {
    const labelRepository = getRepository(LabelEntity);
    const label: LabelEntity = await labelRepository.create(labelData);
    const newLabel: LabelEntity = await labelRepository.save(label);
    return newLabel;
  },

  getLabel: async (id: number): Promise<LabelEntity | null> => {
    const labelRepository = getRepository(LabelEntity);

    const label = await labelRepository.findOne({ id });
    if (!label) return null;
    return label;
  },

  getLabels: async (): Promise<LabelEntity[]> => {
    const labelRepository = getRepository(LabelEntity);
    const labels: LabelEntity[] = await labelRepository.find();

    return labels;
  },

  getLabelsByIssueId: async (issueId: number) => {
    const issueHasLabelRepository = getRepository(IssueHasLabelEntity);
    const labels = await issueHasLabelRepository
      .createQueryBuilder("IssueHasLabel")
      .innerJoinAndSelect("IssueHasLabel.label", "Label")
      .where("IssueHasLabel.issueId = :issueId", { issueId })
      .getMany();
    return labels;
  },

  delete: async (id: number): Promise<void> => {
    const label = await LabelService.getLabel(id);
    if (!label) throw new Error("label does not exist");

    const labelRepository = getRepository(LabelEntity);
    await labelRepository.delete({ id });
  },

  update: async (id: number, body: LabelUpdateToFix): Promise<void> => {
    const labelRepository = getRepository(LabelEntity);
    const label = await LabelService.getLabel(id);

    if (!label) throw new Error("label does not exist");

    await labelRepository.update(label, body);
  },
};

export default LabelService;
