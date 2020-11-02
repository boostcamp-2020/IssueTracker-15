import bcrypt from 'bcrypt';

const Encryption = {
  encryptPassword: async (password: string): Promise<string> => {
    const hashedPassword = await bcrypt.hash(password, 13);
    return hashedPassword;
  }
}

export default Encryption;