import express, { NextFunction, Request, Response } from "express";
import { IssueEntity } from "../entity/issue.entity";
import { IssueService } from "../services/issue.service";
import { createIssue } from "../types/issue.types";
export const IssueRouter = express.Router();

IssueRouter.post(
  "/",
  async (req: Request, res: Response, next: NextFunction) => {
    const newIssueData: createIssue = req.body;
    try {
      const newIssue: IssueEntity = await IssueService.createIssue(
        newIssueData
      );
      res.json(newIssue);
    } catch (e) {
      res.status(400);
    }
  }
);
