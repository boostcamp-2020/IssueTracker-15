import express from "express";
import { SignInRouter } from "./sign-in";
import { SignUpRouter } from "./sign-up";

const AuthRouter = express.Router();

AuthRouter.use("/signin", SignInRouter);
AuthRouter.use("/signup", SignUpRouter);

export { AuthRouter };
