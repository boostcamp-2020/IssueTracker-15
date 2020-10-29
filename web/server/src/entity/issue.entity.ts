import {
  Column,
  Entity,
  JoinColumn,
  ManyToOne,
  OneToMany,
  PrimaryGeneratedColumn,
} from "typeorm";
import { CommentEntity } from "./comment.entity";
import { MilestoneEntity } from "./milestone.entity";
import { UserEntity } from "./user.entity";
import { IssueHasLabelEntity } from "./issue-label.entity";
import { AssigneesEntity } from "./assignees.entity";
@Entity("Issue")
export class IssueEntity {
  @PrimaryGeneratedColumn()
  id!: number;

  @Column({ type: "varchar", nullable: false })
  title!: string;

  @Column({ type: "varchar", nullable: true })
  description?: string;

  @Column({
    type: "timestamp",
    nullable: false,
    default: () => "CURRENT_TIMESTAMP()",
  })
  createAt!: Date;

  @Column({ type: "timestamp", nullable: true })
  updateAt?: Date;

  @Column({ type: "boolean", nullable: false })
  isOpend!: boolean;

  @Column({ type: "number", nullable: true })
  milestoneId?: number;

  @Column({ type: "number", nullable: false })
  authorId!: number;

  @ManyToOne((type) => MilestoneEntity, (milestone) => milestone.issues, {
    onUpdate: "CASCADE",
  })
  @JoinColumn({
    name: "milestoneId",
    referencedColumnName: "id",
  })
  milestone?: MilestoneEntity;

  @ManyToOne((type) => UserEntity, (user) => user.issues, {
    onUpdate: "CASCADE",
  })
  @JoinColumn({
    name: "authorId",
    referencedColumnName: "id",
  })
  author!: UserEntity;

  @OneToMany((type) => CommentEntity, (comment) => comment.issue, {
    cascade: true,
  })
  comments?: CommentEntity[];

  @OneToMany(
    (type) => IssueHasLabelEntity,
    (issueHasLabel) => issueHasLabel.issue,
    { cascade: true }
  )
  issueHasLabels?: IssueHasLabelEntity[];

  @OneToMany((type) => AssigneesEntity, (assignees) => assignees.issue, {
    cascade: true,
  })
  assignees?: AssigneesEntity[];
}
