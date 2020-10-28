import { Column, Entity, PrimaryGeneratedColumn } from "typeorm";

@Entity("Milestone")
export class UserEntity {
  @PrimaryGeneratedColumn()
  id!: number;

  @Column({ type: "varchar", nullable: false })
  title!: string;

  @Column({ type: "varchar", nullable: false })
  description!: string;

  @Column({ type: "timestamp", nullable: true })
  dueDate!: Date;
}
