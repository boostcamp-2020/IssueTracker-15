import express from "express";
import passport from "passport";
import passportConfig from "../lib/passport";

passportConfig();

const passportLoader = (app: express.Application) => {
  app.use(passport.initialize());
  app.use(passport.session());
  passportConfig();
};

export default passportLoader;
