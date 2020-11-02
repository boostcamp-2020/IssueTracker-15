import { getRepository } from "typeorm";
import Encryption from '../lib/encryption'
import UserEntity from "../entity/user.entity";

const SignUpService = {
  create: async (email: string, password: string, userName: string, type: string): Promise<UserEntity> => {
    const hashedPassword = await Encryption.encryptPassword(password);

    const userRepository = getRepository(UserEntity)
    const user: UserEntity = await userRepository.create({ email, password: hashedPassword, userName, type });
    const result: UserEntity = await userRepository.save(user);
    return result;
  }
}

export default SignUpService;