import { Entity, JoinColumn, ManyToOne, PrimaryColumn } from "typeorm";
import { IssueEntity } from "./issue.entity";
import { LabelEntity } from "./label.entity";

@Entity("IssueHasLabel")
export class IssueHasLabelEntity {
  @PrimaryColumn({ type: "int" })
  issueId!: number;

  @PrimaryColumn({ type: "int" })
  labelId!: number;

  @ManyToOne((type) => LabelEntity, (label) => label.issueHasLabel)
  @JoinColumn({
    name: "labelId",
    referencedColumnName: "id",
  })
  label!: LabelEntity;

  @ManyToOne((type) => IssueEntity, (issue) => issue.issueHasLabel)
  @JoinColumn({
    name: "issueId",
    referencedColumnName: "id",
  })
  issue!: IssueEntity;
}
