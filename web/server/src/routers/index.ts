import express from "express";
import AuthRouter from "./auth";
import CommentRouter from "./comment";
import IssueRouter from "./issue";
import LabelRouter from "./label";
import MilestoneRouter from "./milestone";

const APIRouter = express.Router();

APIRouter.use("/auth", AuthRouter);
APIRouter.use("/comment", CommentRouter);
APIRouter.use("/label", LabelRouter);
APIRouter.use("/milestone", MilestoneRouter);
APIRouter.use("/issue", IssueRouter);

export default APIRouter;
