import { Entity, JoinColumn, ManyToOne, PrimaryColumn } from "typeorm";
import { IssueEntity } from "./issue.entity";
import { UserEntity } from "./user.entity";

@Entity("Assignees")
export class AssigneesEntity {
  @PrimaryColumn({ type: "int" })
  userId!: number;

  @PrimaryColumn({ type: "int" })
  issueId!: number;

  @ManyToOne((type) => UserEntity, (user) => user.assignees)
  @JoinColumn({ name: "userId", referencedColumnName: "id" })
  user!: UserEntity;

  @ManyToOne((type) => IssueEntity, (issue) => issue.assignees)
  @JoinColumn({
    name: "issueId",
    referencedColumnName: "id",
  })
  issue!: IssueEntity;
}
