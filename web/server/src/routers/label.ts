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
    return res.status(400).json({
      status: 400,
      message: e.message
    });
  }
});

LabelRouter.get('/', async (req: Request, res: Response) => {
  const { LabelService } = Services;
  try {
    const result = await LabelService.getLabels();
    return res.status(200).json({
      "message": 'OK',
      "status": 200,
      "data": {
        "labels": result
      }
    });
  } catch (e) {
    return res.status(400).json({
      status: 400,
      message: e.message
    });
  }
});

LabelRouter.delete('/:id', async (req: Request, res: Response) => {
  const { id } = req.params
  const { LabelService } = Services;
  try {
    await LabelService.delete(parseInt(id));
    return res.status(200).json({
      "message": 'OK',
      "status": 200
    });
  } catch (e) {
    return res.status(400).json({
      status: 400,
      message: e.message
    });
  }
});

LabelRouter.patch('/:id', async (req: Request, res: Response) => {
  const { id } = req.params;
  const { body } = req;
  const { LabelService } = Services;
  try {
    await LabelService.update(parseInt(id), body);
    return res.status(200).json({
      "message": 'OK',
      "status": 200
    });
  } catch (e) {
    return res.status(400).json({
      status: 400,
      message: e.message
    });
  }
})

export default LabelRouter;
