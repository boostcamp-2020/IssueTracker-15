import express, { Request, Response } from 'express';
import { getRepository, Repository } from 'typeorm';
import CommentEntity from '../entity/comment.entity';
import CommentService from '../services/comment.service';

const CommentRouter = express.Router();

CommentRouter.post('/', async (req: Request, res: Response) => {
  try {
    const { body } = req;
    const newComment = await CommentService.create(body);
    res.json(newComment);
  } catch (err) {
    res.status(400).json({ message: err.message });
  }
});

export default CommentRouter;
