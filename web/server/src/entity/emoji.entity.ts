import { Column, Entity, PrimaryGeneratedColumn } from "typeorm";

@Entity("Comment")
export class UserEntity {
  @PrimaryGeneratedColumn()
  id!: number;

  @Column({ type: "tinyint", nullable: false })
  imageType!: number;
}
