import Token from '../lib/token';

const AuthService = {
  signIn: (user: any) => {
    const token = Token.getToken(user.email, user.name);
    return { token };
  },
};

export default AuthService;
