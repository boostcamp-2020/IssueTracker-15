import express, { NextFunction, Request, Response } from "express";
import cors from "cors";
import bodyParser from "body-parser";
import { APIRouter } from "../routers/";
import { createDBConnection } from "./databse";

const app = express();

export default async ({ app }: { app: express.Application }) => {
  await createDBConnection();

  app.use(cors());
  app.use(bodyParser.json());

  app.use("/api", APIRouter);

  app.use("/", (req: Request, res: Response, next: NextFunction) => {
    res.send("hello");
  });
};
