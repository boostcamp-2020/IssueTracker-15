import { NextFunction, Request, Response } from 'express';
import passport from 'passport';

const PassportMiddleware = {
  validateUser: async (req: Request, res: Response, next: NextFunction) => {
    passport.authenticate('jwt', async (err, user, info) => {
      if (err || info) return res.status(400).json({ message: info.message });

      req.user = user;
      next();
    })(req, res, next);
  },

  signIn: async (req: Request, res: Response, next: NextFunction) => {
    passport.authenticate('local', async (err, user, info) => {
      if (err || info) return res.status(400).json({ message: info.message });

      req.login(user, { session: false }, async (loginErr) => {
        next(loginErr);
      });

      req.user = user;
      next();
    })(req, res, next);
  },
};

export default PassportMiddleware;
