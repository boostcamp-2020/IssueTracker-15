import { Entity, Index, JoinColumn, ManyToOne, PrimaryColumn } from "typeorm";
import { IssueEntity } from "./issue.entity";
import { LabelEntity } from "./label.entity";

@Entity("IssueHasLabel")
export class IssueHasLabelEntity {
  @PrimaryColumn()
  issueId!: number;

  @PrimaryColumn()
  labelId!: number;

  @ManyToOne((type) => LabelEntity, (label) => label.issueHasLabels, {
    onUpdate: "CASCADE",
    onDelete: "CASCADE",
  })
  @JoinColumn({
    name: "labelId",
    referencedColumnName: "id",
  })
  label!: LabelEntity;

  @ManyToOne((type) => IssueEntity, (issue) => issue.issueHasLabels, {
    onUpdate: "CASCADE",
    onDelete: "CASCADE",
  })
  @JoinColumn({
    name: "issueId",
    referencedColumnName: "id",
  })
  issue!: IssueEntity;
}
