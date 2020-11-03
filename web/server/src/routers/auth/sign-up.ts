import express, { Request, Response } from 'express';
import SignUpService from '../../services/sign-up.service';

const SignUpRouter = express.Router();

SignUpRouter.post('/', async (req: Request, res: Response) => {
  const { user_id, password, userName } = req.body;
  try {
    const result = await SignUpService.create(
      user_id,
      password,
      userName,
      'local'
    );

    return res.status(200).json();
  } catch (err) {
    return res.status(400).json({ message: err.message });
  }
});

export default SignUpRouter;
