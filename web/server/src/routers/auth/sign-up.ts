import express, { Request, Response } from "express";
import SignUpService from "../../services/sign-up.service";

const SignUpRouter = express.Router();

SignUpRouter.post('/', async (req: Request, res: Response) => {
  const { user_id, password, userName } = req.body;
  try {
    const result = await SignUpService.create(user_id, password, userName, 'local');
    console.log(result);
    res.status(200).json({ status: 200, message: "OK" });
  } catch (err) {
    res.status(400).json({ status: 400, message: err.message })
  }
})

export default SignUpRouter;
