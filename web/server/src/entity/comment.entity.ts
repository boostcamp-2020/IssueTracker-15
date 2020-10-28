import {
  Column,
  Entity,
  JoinColumn,
  ManyToOne,
  PrimaryGeneratedColumn,
} from "typeorm";
import { IssueEntity } from "./issue.entity";
import { UserEntity } from "./user.entity";

@Entity("Comment")
export class CommentEntity {
  @PrimaryGeneratedColumn()
  id!: number;

  @Column({ type: "varchar", nullable: false })
  content!: string;

  @Column({
    type: "timestamp",
    nullable: false,
    default: () => "CURRENT_TIMESTAMP()",
  })
  createAt!: Date;

  @Column({ type: "int" })
  userId!: number;

  @Column({ type: "int" })
  issueId!: number;

  @ManyToOne((type) => UserEntity, (user) => user.id)
  @JoinColumn({
    name: "userId",
    referencedColumnName: "id",
  })
  user!: UserEntity;

  @ManyToOne((type) => IssueEntity, (issue) => issue.comment)
  @JoinColumn({
    name: "issueId",
    referencedColumnName: "id",
  })
  issue!: IssueEntity;
}
