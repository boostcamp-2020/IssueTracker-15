import express, { Request, Response } from 'express';
import PassportMiddleware from '../../middlewares/passport';
import AuthService from '../../services/auth';

const SignInRouter = express.Router();

SignInRouter.post(
  '/local',
  PassportMiddleware.signIn,
  async (req: Request, res: Response) => {
    try {
      const user = req.user;
      const result = await AuthService.signIn(user);

      return res.status(200).json(result);
    } catch (err) {
      return res.status(400).json({ message: err.message });
    }
  }
);

export default SignInRouter;
