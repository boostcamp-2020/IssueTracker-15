import passport from 'passport'
import { Strategy as LocalStrategy } from 'passport-local';

import bcrypt from 'bcrypt';
import { getRepository } from 'typeorm';
import UserEntity from '../../entity/user.entity';

const passportConfig = {
  usernameField: 'email',
  passwordField: 'password'
};

const passportVerify = async (email: string, password: string, done: any) => {
  const userRepository = await getRepository(UserEntity);
  try {
    const user = await userRepository.findOne({ email });

    if (!user) {
      return done(null, false, {
        reason: 'User does not exist'
      });
    }

    const result = await bcrypt.compare(password, user.password);

    if (result) {
      return done(null, user);
    }
  } catch (err) {
    console.error(err);
    return done(err);
  }
}


const local = () => {
  passport.use(new LocalStrategy(passportConfig, passportVerify));
};

export default local;