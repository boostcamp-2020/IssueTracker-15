import express from "express";
import expressLoader from "./express";

export default (expressApp: express.Application): void => {
  expressLoader({ app: expressApp });
  console.log("✌️ Express loaded");
};
