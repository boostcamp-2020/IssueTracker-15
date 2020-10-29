import { Column, Entity, OneToMany, PrimaryGeneratedColumn } from "typeorm";
import { AssigneesEntity } from "./assignees.entity";
import { CommentEntity } from "./comment.entity";
import { IssueEntity } from "./issue.entity";
@Entity("User")
export class UserEntity {
  @PrimaryGeneratedColumn({ type: "int" })
  id!: number;

  @Column({ type: "varchar", nullable: false })
  email!: string;

  @Column({ type: "varchar", nullable: false })
  password!: string;

  @Column({ type: "varchar", nullable: false })
  userName!: string;

  @Column({ type: "varchar", nullable: true })
  imageURL?: string;

  @Column({ type: "varchar", nullable: false })
  type!: string;

  @OneToMany((type) => CommentEntity, (comment) => comment.user, {
    cascade: true,
  })
  comments?: CommentEntity[];

  @OneToMany((type) => IssueEntity, (issue) => issue.author, { cascade: true })
  issues?: IssueEntity[];

  @OneToMany((type) => AssigneesEntity, (assigness) => assigness.user, {
    cascade: true,
  })
  assignees?: AssigneesEntity[];
}
