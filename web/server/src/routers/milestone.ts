import express, { Request, Response } from "express";
import MilestoneService from "../services/milestone.service";
import { Milestone } from "../types/milestone.types";

const MilestoneRouter = express.Router();
MilestoneRouter.get("/", async (req: Request, res: Response) => {
  try {
    const newMilestones = await MilestoneService.getMilestones();
    return res.json(newMilestones);
  } catch (e) {
    return res.status(400).json(e.message);
  }
});

MilestoneRouter.post("/", async (req: Request, res: Response) => {
  const newMilestoneData: Milestone = req.body;

  try {
    const newMilestone = await MilestoneService.createMilestone(
      newMilestoneData
    );
    return res.status(201).json(newMilestone);
  } catch (e) {
    return res.status(400).json(e.message);
  }
});

MilestoneRouter.delete("/:id", async (req: Request, res: Response) => {
  const milestoneId = parseInt(req.params.id, 10);

  try {
    await MilestoneService.deleteMilestone(milestoneId);
    return res.status(204).json();
  } catch (e) {
    return res.status(400).json(e.message);
  }
});

MilestoneRouter.patch("/:id", async (req: Request, res: Response) => {
  const milestoneId = parseInt(req.params.id, 10);
  const newMilestoneData: Milestone = req.body;

  try {
    await MilestoneService.updateMilestone(milestoneId, newMilestoneData);
    return res.json();
  } catch (e) {
    return res.status(400).json(e.message);
  }
});
export default MilestoneRouter;
