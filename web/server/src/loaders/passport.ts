import express from 'express'
import passport from 'passport';
import passportConfig from '../lib/passport';

passportConfig();

const passportLoader = (app: express.Application) => {
  app.use(passport.initialize());
  passportConfig();
}

export default passportLoader;