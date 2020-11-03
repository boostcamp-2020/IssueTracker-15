import express, { Request, Response } from 'express';
import SignUpService from '../../services/sign-up.service';

const SignUpRouter = express.Router();

SignUpRouter.post('/', async (req: Request, res: Response) => {
  const { email, password, userName } = req.body;
  try {
    await SignUpService.create(email, password, userName, 'local');
    return res.json();
  } catch (err) {
    return res.status(400).json({ message: err.message });
  }
});

export default SignUpRouter;
