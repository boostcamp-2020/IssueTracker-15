import { Column, Entity, PrimaryGeneratedColumn } from "typeorm";

@Entity("Emoji")
export class EmojiEntity {
  @PrimaryGeneratedColumn()
  id!: number;

  @Column({ type: "tinyint", nullable: false })
  imageType!: number;
}
