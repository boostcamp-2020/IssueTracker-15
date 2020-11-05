import jsonwebtoken from 'jsonwebtoken';

const Token = {
  getToken: (email: string, name: string) => {
    return jsonwebtoken.sign({ email, name }, process.env.TOKEN_SECRET as string, {
      expiresIn: '6d'
    }
    );
  }
}

export default Token;