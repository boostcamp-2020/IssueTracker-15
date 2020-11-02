import { IsNotEmpty, IsString } from "class-validator";

export default class UpdateIssueContent {
  @IsString()
  @IsNotEmpty()
  description!: string;
}
