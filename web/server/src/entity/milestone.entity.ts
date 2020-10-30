import { Column, Entity, OneToMany, PrimaryGeneratedColumn } from "typeorm";
import IssueEntity from "./issue.entity";

@Entity("Milestone")
class MilestoneEntity {
  @PrimaryGeneratedColumn()
  id!: number;

  @Column({ type: "varchar", nullable: false })
  title!: string;

  @Column({ type: "varchar", nullable: false })
  description!: string;

  @Column({ type: "timestamp", nullable: true })
  dueDate?: Date;

  @OneToMany(() => IssueEntity, (issue) => issue.milestone, {
    cascade: true,
  })
  issues?: IssueEntity[];
}
export default MilestoneEntity;
