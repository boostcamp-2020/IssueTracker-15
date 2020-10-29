import { Entity, JoinColumn, ManyToOne, PrimaryColumn } from "typeorm";
import IssueEntity from "./issue.entity";
import LabelEntity from "./label.entity";

@Entity("IssueHasLabel")
class IssueHasLabelEntity {
  @PrimaryColumn()
  issueId!: number;

  @PrimaryColumn()
  labelId!: number;

  @ManyToOne(() => LabelEntity, (label) => label.issueHasLabels, {
    onUpdate: "CASCADE",
    onDelete: "CASCADE",
  })
  @JoinColumn({
    name: "labelId",
    referencedColumnName: "id",
  })
  label!: LabelEntity;

  @ManyToOne(() => IssueEntity, (issue) => issue.issueHasLabels, {
    onUpdate: "CASCADE",
    onDelete: "CASCADE",
  })
  @JoinColumn({
    name: "issueId",
    referencedColumnName: "id",
  })
  issue!: IssueEntity;
}

export default IssueHasLabelEntity;
