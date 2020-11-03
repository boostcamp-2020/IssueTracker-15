import { getRepository, Repository } from "typeorm";
import CommentEntity from "../entity/comment.entity";

const CommentService = {
  create: async (body: CommentEntity): Promise<CommentEntity> => {
    const commentRepository: Repository<CommentEntity> = getRepository(
      CommentEntity
    );
    const comment: CommentEntity = await commentRepository.create(body);
    const newComment: CommentEntity = await commentRepository.save(comment);
    return newComment;
  },

  getCommentsByIssueId: async (issueId: number) => {
    const commentRepository = getRepository(CommentEntity);
    const comments = await commentRepository
      .createQueryBuilder("Comment")
      .innerJoin("Comment.user", "User")
      .where("Comment.issueId = :issueId", { issueId })
      .select([
        "Comment.id",
        "Comment.content",
        "Comment.createAt",
        "User.userName",
        "User.imageURL",
      ])
      .getMany();

    return comments;
  },
};

export default CommentService;
