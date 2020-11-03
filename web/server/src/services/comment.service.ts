import { getRepository, Repository } from 'typeorm';
import CommentEntity from '../entity/comment.entity';

const CommentService = {
  create: async (body: CommentEntity): Promise<CommentEntity> => {
    const commentRepository: Repository<CommentEntity> = getRepository(
      CommentEntity
    );
    const comment: CommentEntity = await commentRepository.create(body);
    const newComment: CommentEntity = await commentRepository.save(comment);
    return newComment;
  },
};

export default CommentService;
