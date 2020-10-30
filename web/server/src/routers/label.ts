import express, { Request, Response } from "express";

import Services from "../services";

const LabelRouter = express.Router();

LabelRouter.post("/", async (req: Request, res: Response) => {
  const { body } = req;
  const { LabelService } = Services;

  try {
    const result = await LabelService.create(body);
    return res.status(200).json(result);
  } catch (e) {
    return res.status(400).json(e);
  }
});

export default LabelRouter;
