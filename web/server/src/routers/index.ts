import express from "express";
import AuthRouter from "./auth";
import CommentRouter from "./comment";
import IssueRouter from "./issue";
import LabelRouter from "./label";
import MilestoneRouter from "./milestone";
import SignUpRouter from "./auth/sign-up";

const APIRouter = express.Router();

APIRouter.use("/auth", AuthRouter);
APIRouter.use("/comment", CommentRouter);
APIRouter.use("/label", LabelRouter);
APIRouter.use("/milestone", MilestoneRouter);
APIRouter.use("/issue", IssueRouter);
APIRouter.use("/signup", SignUpRouter)

export default APIRouter;
