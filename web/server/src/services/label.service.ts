import { getRepository } from "typeorm";
import { Label } from "../types/label.type";
import LabelEntity from "../entity/label.entity";

const LabelService = {
  create: async (labelData: Label): Promise<LabelEntity> => {
    const labelRepository = getRepository(LabelEntity);
    const label: LabelEntity = await labelRepository.create(labelData);
    const results: LabelEntity = await labelRepository.save(label);
    return results;
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

  delete: async (id: number): Promise<void> => {

    const label = await LabelService.getLabel(id);

    if (!label) throw new Error("id is not exist");

    const labelRepository = getRepository(LabelEntity);
    await labelRepository.delete({ id })
  }
};

export default LabelService;
