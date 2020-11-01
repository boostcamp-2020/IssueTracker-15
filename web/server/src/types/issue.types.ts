import { IsNotEmpty, IsNumber, IsString } from "class-validator";

export class CreateIssue {
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

export class UpdateIssueTitle {
  @IsString()
  @IsNotEmpty()
  title!: string;
}

export class UpdateIssueContent {
  @IsString()
  @IsNotEmpty()
  description!: string;
}
