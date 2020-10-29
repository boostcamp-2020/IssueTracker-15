import express, { NextFunction, Request, Response } from 'express';
import { LabelType } from '../types';
import { LabelService } from '../services';

const LabelRouter = express.Router();

LabelRouter.post(
  '/',
  async (req: Request, res: Response, next: NextFunction) => {
    const body: LabelType.Label = req.body;
    try {
      const result = await LabelService.create(body);
      return res.status(200).json(result);
    } catch (e) {
      return res.status(400).json(e);
    }
  }
);

export { LabelRouter };
