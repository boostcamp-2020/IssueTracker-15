import express, { Request, Response } from "express";
import IssueEntity from "../entity/issue.entity";
import IssueService from "../services/issue.service";
import {
  CreateIssue,
  UpdateIssueContent,
  UpdateIssueTitle,
} from "../types/issue";

const IssueRouter = express.Router();

IssueRouter.post(
  "/:issueId/assignees/:userId",
  async (req: Request, res: Response) => {
    const issueId = Number(req.params.issueId);
    const userId = Number(req.params.userId);
    try {
      await IssueService.addAssigneesToIssue(issueId, userId);
      res.status(201).json();
    } catch (e) {
      res.status(400).json({ message: e.message });
    }
  }
);

IssueRouter.delete(
  "/:issueId/assignees/:userId",
  async (req: Request, res: Response) => {
    const issueId = Number(req.params.issueId);
    const userId = Number(req.params.userId);
    try {
      await IssueService.deleteAssigneesToIssue(issueId, userId);
      res.status(204).json();
    } catch (e) {
      res.status(400).json({ message: e.message });
    }
  }
);

IssueRouter.post(
  "/:issueId/milestone/:milestoneId",
  async (req: Request, res: Response) => {
    const issueId = Number(req.params.issueId);
    const milestoneId = Number(req.params.milestoneId);
    try {
      await IssueService.addMilestoneToIssue(issueId, milestoneId);
      res.status(201).json();
    } catch (e) {
      res.status(400).json({ message: e.message });
    }
  }
);

IssueRouter.delete(
  "/:issueId/milestone/:milestoneId",
  async (req: Request, res: Response) => {
    const issueId = Number(req.params.issueId);
    const milestoneId = Number(req.params.milestoneId);
    try {
      await IssueService.deleteMilestoneAtIssue(issueId);
      res.status(204).json();
    } catch (e) {
      res.status(400).json({ message: e.message });
    }
  }
);

IssueRouter.post(
  "/:issueId/label/:labelId",
  async (req: Request, res: Response) => {
    const issueId = Number(req.params.issueId);
    const labelId = Number(req.params.labelId);
    try {
      await IssueService.addLabelToIssue(issueId, labelId);
      res.status(201).json();
    } catch (e) {
      res.status(400).json({ message: e.message });
    }
  }
);

IssueRouter.delete(
  "/:issueId/label/:labelId",
  async (req: Request, res: Response) => {
    const issueId = Number(req.params.issueId);
    const labelId = Number(req.params.labelId);
    try {
      await IssueService.deleteLabelAtIssue(issueId, labelId);
      res.status(204).json();
    } catch (e) {
      res.status(400).json({ message: e.message });
    }
  }
);

IssueRouter.patch("/:issueId/title", async (req: Request, res: Response) => {
  const issueId = Number(req.params.issueId);
  try {
    const newTitle: UpdateIssueTitle = req.body;
    await IssueService.updateIssueTitle(issueId, newTitle);
    res.json();
  } catch (e) {
    res.status(400).json({ message: e.message });
  }
});

IssueRouter.get("/:issueId", async (req: Request, res: Response) => {
  const issueId = Number(req.params.issueId);
  try {
    const issue = await IssueService.getDetailIssueById(issueId);
    res.json(issue);
  } catch (e) {
    res.status(400).json({ message: e.message });
  }
});

IssueRouter.patch("/:issueId", async (req: Request, res: Response) => {
  const issueId = Number(req.params.issueId);
  try {
    const newDiscription: UpdateIssueContent = req.body;
    await IssueService.updateIssueContent(issueId, newDiscription);
    res.json();
  } catch (e) {
    res.status(400).json({ message: e.message });
  }
});

IssueRouter.delete("/:issueId", async (req: Request, res: Response) => {
  const issueId = Number(req.params.issueId);
  try {
    await IssueService.deleteIssue(issueId);
    res.status(204).json();
  } catch (e) {
    res.status(400).json({ message: e.message });
  }
});

IssueRouter.get("/count", async (req: Request, res: Response) => {
  try {
    const issueCount = await IssueService.getIssueOverAllCount();
    res.json(issueCount);
  } catch (e) {
    res.status(404).json({ message: e.message });
  }
});

IssueRouter.get("/", async (req: Request, res: Response) => {
  try {
    const isOpened = req.query.isOpened === "true" ? true : false;

    const Issues = await IssueService.getIssues(isOpened);

    res.json(Issues);
  } catch (e) {
    res.status(404).json({ message: e.message });
  }
});

IssueRouter.post("/", async (req: Request, res: Response) => {
  const newIssueData: CreateIssue = req.body;
  try {
    const newIssue: IssueEntity = await IssueService.createIssue(newIssueData);
    res.status(201).json(newIssue);
  } catch (e) {
    res.status(400).json({ message: e.message });
  }
});

export default IssueRouter;
