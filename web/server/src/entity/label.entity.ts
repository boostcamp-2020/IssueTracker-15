import { Column, Entity, OneToMany, PrimaryGeneratedColumn } from "typeorm";
import { IssueHasLabelEntity } from "./issue-label.entity";

@Entity("Label")
export class LabelEntity {
  @PrimaryGeneratedColumn({ type: "int" })
  id!: number;

  @Column({ type: "varchar", nullable: false })
  title!: string;

  @Column({ type: "varchar", nullable: false })
  description!: string;

  @Column({ type: "varchar", nullable: false })
  color!: string;

  @OneToMany(
    (type) => IssueHasLabelEntity,
    (issueHasLabel) => issueHasLabel.label,
    { cascade: true }
  )
  issueHasLabels?: IssueHasLabelEntity[];
}
