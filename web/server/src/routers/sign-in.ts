import express, { Request, Response } from "express";
import Token from "../lib/token";
import PassportMiddleware from "../middlewares/passport";
import AuthService from "../services/auth";
import axios from "axios";

const SignInRouter = express.Router();

SignInRouter.post(
  "/local",
  PassportMiddleware.signInLocal,
  async (req: Request, res: Response) => {
    try {
      const user = req.user;
      const loginData = await AuthService.signIn(user);

      return res.json(loginData);
    } catch (err) {
      return res.status(400).json({ message: err.message });
    }
  }
);

SignInRouter.post("/github", async (req: Request, res: Response) => {
  const { code } = req.body;
  try {
    const response = await axios.post(
      "https://github.com/login/oauth/access_token",
      {
        code,
        client_id: process.env.CLIENT_ID,
        client_secret: process.env.CLIENT_SECRET,
      },
      {
        headers: {
          accept: "application/json",
        },
      }
    );

    const token = response.data.access_token;

    const { data } = await axios.get("https://api.github.com/user", {
      headers: {
        Authorization: `token ${token}`,
      },
    });

    const accessToken = Token.getToken(data.email, data.name);

    return res.json({ accessToken });
  } catch (e) {
    console.log(e.message);
  }
});

export default SignInRouter;
