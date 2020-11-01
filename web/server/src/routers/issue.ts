import express, { Request, Response } from "express";
import IssueEntity from "../entity/issue.entity";
import IssueService from "../services/issue.service";
import {
  CreateIssue,
  UpdateIssueContent,
  UpdateIssueTitle,
} from "../types/issue.types";

const IssueRouter = express.Router();

IssueRouter.get("/", async (req: Request, res: Response) => {
  try {
    const issues = await IssueService.getIssues();
    res.json(issues);
  } catch (e) {
    res.status(404);
  }
});

IssueRouter.patch("/:issueId/title", async (req: Request, res: Response) => {
  const issueId = Number(req.params.issueId);
  try {
    const newTitle: UpdateIssueTitle = req.body;
    await IssueService.updateIssueTitle(issueId, newTitle);
    res.json({ result: "success" });
  } catch (e) {
    res.status(400);
  }
});

IssueRouter.patch("/:issueId", async (req: Request, res: Response) => {
  const issueId = Number(req.params.issueId);
  try {
    const newDiscription: UpdateIssueContent = req.body;
    await IssueService.updateIssueContent(issueId, newDiscription);
    res.json({ result: "success" });
  } catch (e) {
    res.status(400);
  }
});

IssueRouter.post("/", async (req: Request, res: Response) => {
  const newIssueData: CreateIssue = req.body;
  try {
    const newIssue: IssueEntity = await IssueService.createIssue(newIssueData);
    res.json(newIssue);
  } catch (e) {
    res.status(400);
  }
});

export default IssueRouter;
