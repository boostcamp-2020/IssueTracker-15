import { getRepository } from "typeorm";
import Encryption from "../lib/encryption";
import UserEntity from "../entity/user.entity";
import { SignUpInput } from "../types/sign-up.type";

const UserService = {
  create: async (
    signUpInput: SignUpInput,
    type: string
  ): Promise<UserEntity> => {
    const { email, password, userName } = signUpInput;

    const hashedPassword = await Encryption.encryptPassword(password);

    const userRepository = getRepository(UserEntity);
    const user: UserEntity = await userRepository.create({
      email,
      password: hashedPassword,
      userName,
      type,
    });
    const newUser: UserEntity = await userRepository.save(user);
    return newUser;
  },

  getAssigneeList: async (issueId: number) => {
    const userRepository = getRepository(UserEntity);
    const assignees = await userRepository
      .createQueryBuilder("User")
      .innerJoin("User.assignees", "Assignees")
      .select(["User.userName", "User.imageURL"])
      .where("Assignees.issueId = :issueId", { issueId })
      .getMany();

    return assignees;
  },
};

export default UserService;