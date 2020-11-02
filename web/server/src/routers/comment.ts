import express, { Request, Response } from "express";
import { getRepository, Repository } from "typeorm";
import CommentEntity from "../entity/comment.entity";
import CommentService from "../services/comment.service";

const CommentRouter = express.Router();

CommentRouter.post('/', async (req: Request, res: Response) => {
  try {
    const { body } = req;
    const result = await CommentService.create(body);
    res.status(200).json({ status: 200, message: "OK", data: result })
  } catch (err) {
    res.status(400).json({ message: err.message });
  }
})

export default CommentRouter;
