import express, { Request, Response } from 'express';

import Services from '../services';

const LabelRouter = express.Router();

LabelRouter.post('/', async (req: Request, res: Response) => {
  const { body } = req;
  const { LabelService } = Services;

  try {
    const createdLabel = await LabelService.create(body);
    return res.status(201).json(createdLabel);
  } catch (e) {
    return res.status(400).json({
      message: e.message,
    });
  }
});

LabelRouter.get('/', async (req: Request, res: Response) => {
  const { LabelService } = Services;

  try {
    const labels = await LabelService.getLabels();
    return res.status(200).json(labels);
  } catch (e) {
    return res.status(400).json({
      message: e.message,
    });
  }
});

LabelRouter.delete('/:id', async (req: Request, res: Response) => {
  const { id } = req.params;
  const { LabelService } = Services;

  try {
    await LabelService.delete(parseInt(id));
    return res.status(204).json();
  } catch (e) {
    return res.status(400).json({
      message: e.message,
    });
  }
});

LabelRouter.patch('/:id', async (req: Request, res: Response) => {
  const { id } = req.params;
  const { body } = req;
  const { LabelService } = Services;

  try {
    await LabelService.update(parseInt(id), body);
    return res.status(200).json();
  } catch (e) {
    return res.status(400).json({
      message: e.message,
    });
  }
});

export default LabelRouter;
