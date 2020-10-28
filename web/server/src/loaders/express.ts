import express, { NextFunction, Request, Response } from "express";
import cors from "cors";
import bodyParser from "body-parser";
import { APIRouter } from "../routers/";

const app = express();

export default ({ app }: { app: express.Application }) => {
  app.use(cors());
  app.use(bodyParser.json());

  app.use("/api", APIRouter);

  app.use("/", (req: Request, res: Response, next: NextFunction) => {
    res.send("hello");
  });
};
