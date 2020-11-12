import UserEntity from "../entity/user.entity";

export default class UserDTO {
  constructor(user: UserEntity) {
    this.id = user.id;
    this.userName = user.userName;
    this.imageURL = user.imageURL ? user.imageURL : null;
  }

  id: number;
  userName: string;
  imageURL: string | null;
}
