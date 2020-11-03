import passport from 'passport';

import { ExtractJwt, Strategy as JWTStrategy } from 'passport-jwt'
import { getRepository } from 'typeorm';
import UserEntity from '../../entity/user.entity';

const JWTConfig = {
  jwtFromRequest: ExtractJwt.fromHeader('authorization'),
  secretOrKey: process.env.TOKEN_SECRET
}

const JWTVerify = async (jwtPayload: any, done: any) => {
  const userRepository = await getRepository(UserEntity);
  try {
    const user = await userRepository.findOne({ email: jwtPayload.email });
    if (user) {
      done(null, user);
      return;
    }

    done(null, false, { reason: '올바르지 않은 인증정보 입니다.' });
  } catch (err) {
    console.error(err)
    done(err);
  }
}
const jwt = () => {
  passport.use(new JWTStrategy(JWTConfig, JWTVerify));
}

export default jwt;