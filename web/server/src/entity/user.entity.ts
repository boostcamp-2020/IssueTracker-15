import { Column, Entity, PrimaryGeneratedColumn } from "typeorm";

@Entity("User")
export class UserEntity {
  @PrimaryGeneratedColumn()
  id!: number;

  @Column({ type: "varchar", nullable: false })
  email!: string;

  @Column({ type: "varchar", nullable: false })
  password!: string;

  @Column({ type: "varchar", nullable: false })
  userName!: string;

  @Column({ type: "varchar", nullable: true })
  imageURL!: string;

  @Column({ type: "varchar", nullable: false })
  type!: string;
}
