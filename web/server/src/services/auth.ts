import Token from '../lib/token'

const AuthService = {
  signIn: (user: any) => {
    const token = Token.getToken(user.email, user.name);
    return { message: 'OK', data: { token } };
  },
}

export default AuthService;