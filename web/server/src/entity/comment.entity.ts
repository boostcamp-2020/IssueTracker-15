import { Column, Entity, PrimaryGeneratedColumn } from "typeorm";

@Entity("Comment")
export class UserEntity {
  @PrimaryGeneratedColumn()
  id!: number;

  @Column({ type: "varchar", nullable: false })
  content!: string;

  @Column({
    type: "timestamp",
    nullable: true,
    default: () => "CURRENT_TIMESTAMP()",
  })
  createAt!: Date;
}
