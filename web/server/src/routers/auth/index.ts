import express from 'express';
import SignInRouter from './sign-in';

const AuthRouter = express.Router();

AuthRouter.use('/signin', SignInRouter);

export default AuthRouter;
