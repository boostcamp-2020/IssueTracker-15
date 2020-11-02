import bcrypt from 'bcrypt';
import dotenv from 'dotenv';

dotenv.config();

const Encryption = {
  encryptPassword: async (password: string): Promise<string> => {
    const hashedPassword = await bcrypt.hash(password, parseInt(process.env.ENCRYPT_TIMES as string));
    return hashedPassword;
  }
}

export default Encryption;