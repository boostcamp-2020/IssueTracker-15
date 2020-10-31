import express, { Request, Response } from "express";
import MilestoneEntity from "../entity/issue.entity";
import { createMilestone } from "../types/milestone.types";

const MilestoneRouter = express.Router();
MilestoneRouter.post("/", async (req: Request, res: Response) => {
  const newMilestoneData: createMilestone = req.body;

  try {
    res.json("hello");
  } catch (e) {}
});
export default MilestoneRouter;
