import { IsNotEmpty, IsNumber, IsString } from "class-validator";

export default class CreateIssue {
  @IsString()
  @IsNotEmpty()
  title!: string;

  @IsString()
  @IsNotEmpty()
  description!: string;

  @IsNumber()
  milesotneId?: number;

  @IsNumber()
  authorId!: number;
}
