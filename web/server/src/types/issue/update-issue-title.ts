import { IsNotEmpty, IsString } from "class-validator";

export default class UpdateIssueTitle {
  @IsString()
  @IsNotEmpty()
  title!: string;
}
