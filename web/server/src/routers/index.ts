import express from "express";
import AuthRouter from "./auth";
import CommentRouter from "./comment";
import IssueRouter from "./issue";
import LabelRouter from "./label";
import MilestoneRouter from "./milestone";
import SignUpRouter from "./auth/sign-up";
import SignInRouter from './auth/sign-in'

const APIRouter = express.Router();

APIRouter.use("/auth", AuthRouter);
APIRouter.use("/comment", CommentRouter);
APIRouter.use("/label", LabelRouter);
APIRouter.use("/milestone", MilestoneRouter);
APIRouter.use("/issue", IssueRouter);
APIRouter.use("/signup", SignUpRouter);
APIRouter.use("/signin", SignInRouter);

export default APIRouter;
