import express from "express";
import CommentRouter from "./comment";
import IssueRouter from "./issue";
import LabelRouter from "./label";
import MilestoneRouter from "./milestone";
import SignUpRouter from "./sign-up";
import SignInRouter from "./sign-in";
import UserRouter from "./user";
const APIRouter = express.Router();

APIRouter.use("/comment", CommentRouter);
APIRouter.use("/label", LabelRouter);
APIRouter.use("/milestone", MilestoneRouter);
APIRouter.use("/issue", IssueRouter);
APIRouter.use("/signup", SignUpRouter);
APIRouter.use("/signin", SignInRouter);
APIRouter.use("/user", UserRouter);

export default APIRouter;
