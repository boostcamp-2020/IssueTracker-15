import express, { Request, Response } from "express";
import UserService from "../services/user.service";
import { SignUpInput } from "../types/sign-up.type";

const SignUpRouter = express.Router();

SignUpRouter.post("/", async (req: Request, res: Response) => {
  const { email, password, userName } = req.body;

  const signUpInput: SignUpInput = {
    email,
    password,
    userName,
  };

  try {
    await UserService.create(signUpInput, "local");
    return res.json();
  } catch (err) {
    return res.status(400).json({ message: err.message });
  }
});

export default SignUpRouter;
