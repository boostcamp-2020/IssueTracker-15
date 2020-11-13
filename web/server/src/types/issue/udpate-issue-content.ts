import { IsBoolean, IsString } from "class-validator";

export default class UpdateIssue {
  @IsString()
  title?: string;

  @IsString()
  description?: string;

  @IsBoolean()
  isOpened?: boolean;
}
