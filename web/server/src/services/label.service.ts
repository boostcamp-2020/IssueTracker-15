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

  getLabels: async (): Promise<LabelEntity[]> => {
    const labelRepository = getRepository(LabelEntity);
    const labels: LabelEntity[] = await labelRepository.find();

    return labels;
  }
};

export default LabelService;
