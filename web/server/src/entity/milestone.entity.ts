import { Column, Entity, OneToMany, PrimaryGeneratedColumn } from "typeorm";
import { IssueEntity } from "./issue.entity";

@Entity("Milestone")
export class MilestoneEntity {
  @PrimaryGeneratedColumn()
  id!: number;

  @Column({ type: "varchar", nullable: false })
  title!: string;

  @Column({ type: "varchar", nullable: false })
  description!: string;

  @Column({ type: "timestamp", nullable: true })
  dueDate?: Date;

  @OneToMany((type) => IssueEntity, (issue) => issue.milestoneId)
  issue?: IssueEntity[];
}
