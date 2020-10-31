import {
  Column,
  Entity,
  JoinColumn,
  ManyToOne,
  OneToMany,
  PrimaryGeneratedColumn,
  CreateDateColumn,
  UpdateDateColumn,
} from "typeorm";
import CommentEntity from "./comment.entity";
import MilestoneEntity from "./milestone.entity";
import UserEntity from "./user.entity";
import IssueHasLabelEntity from "./issue-label.entity";
import AssigneesEntity from "./assignees.entity";

@Entity("Issue")
class IssueEntity {
  @PrimaryGeneratedColumn()
  id!: number;

  @Column({ type: "varchar", nullable: false })
  title!: string;

  @Column({ type: "varchar", nullable: true })
  description?: string;

  @CreateDateColumn()
  createAt!: Date;

  @UpdateDateColumn()
  updateAt?: Date;

  @Column({ type: "boolean", nullable: false, default: true })
  isOpend!: boolean;

  @Column({ type: "number", nullable: true })
  milestoneId?: number;

  @Column({ type: "number", nullable: false })
  authorId!: number;

  @ManyToOne(() => MilestoneEntity, (milestone) => milestone.issues, {
    onUpdate: "CASCADE",
  })
  @JoinColumn({
    name: "milestoneId",
    referencedColumnName: "id",
  })
  milestone?: MilestoneEntity;

  @ManyToOne(() => UserEntity, (user) => user.issues, {
    onUpdate: "CASCADE",
  })
  @JoinColumn({
    name: "authorId",
    referencedColumnName: "id",
  })
  author!: UserEntity;

  @OneToMany(() => CommentEntity, (comment) => comment.issue, {
    cascade: true,
  })
  comments?: CommentEntity[];

  @OneToMany(
    () => IssueHasLabelEntity,
    (issueHasLabel) => issueHasLabel.issue,
    { cascade: true }
  )
  issueHasLabels?: IssueHasLabelEntity[];

  @OneToMany(() => AssigneesEntity, (assignees) => assignees.issue, {
    cascade: true,
  })
  assignees?: AssigneesEntity[];
}

export default IssueEntity;
