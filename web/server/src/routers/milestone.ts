import express, { Request, Response } from "express";
import MilestoneService from "../services/milestone.service";
import { createMilestone } from "../types/milestone.types";

const MilestoneRouter = express.Router();
MilestoneRouter.post("/", async (req: Request, res: Response) => {
  const newMilestoneData: createMilestone = req.body;

  try {
    await MilestoneService.createMilestone(newMilestoneData);
    return res.status(200);
  } catch (e) {
    return res.status(400).json(e.message);
  }
});

MilestoneRouter.delete("/:id", async (req: Request, res: Response) => {
  const milestoneId = parseInt(req.params.id, 10);

  try {
    await MilestoneService.deleteMilestone(milestoneId);
    return res.status(200);
  } catch (e) {
    return res.status(400).json(e.message);
  }
});
export default MilestoneRouter;
