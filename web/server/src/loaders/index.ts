import express from "express";
import expressLoader from "./express";
import passportLoader from "./passport";

export default (expressApp: express.Application): void => {
  expressLoader({ app: expressApp });
  passportLoader(expressApp);

  console.log("✌️ Express loaded");
};
