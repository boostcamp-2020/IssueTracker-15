import express, { Request, Response } from "express";
import Token from "../lib/token";
import PassportMiddleware from "../middlewares/passport";
import AuthService from "../services/auth";
import axios from "axios";
import UserService from "../services/user.service";

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
  const { code, type } = req.body;
  console.log(type, process.env.IOS_CLIENT_ID, process.env.IOS_CLIENT_SECRET);
  try {
    const response = await axios.post(
      "https://github.com/login/oauth/access_token",
      {
        code,
        client_id: type ? process.env.IOS_CLIENT_ID : process.env.WEB_CLIENT_ID,
        client_secret: type
          ? process.env.IOS_CLIENT_SECRET
          : process.env.WEB_CLIENT_SECRET,
      },
      {
        headers: {
          accept: "application/json",
        },
      }
    );
    console.log(response.data);
    const token = response.data.access_token;

    const { data } = await axios.get("https://api.github.com/user", {
      headers: {
        Authorization: `token ${token}`,
      },
    });
    let user = await UserService.getExistUser(data.login);
    if (!user) {
      user = await UserService.create(
        {
          email: data.login,
          password: data.node_id,
          userName: data.login,
          imageURL: data.avatar_url,
        },
        "github"
      );
    }

    const accessToken = Token.getToken(user.email, user.userName);
    console.log(accessToken);
    return res.json({
      accessToken,
      user: { id: user.id, userName: user.userName, imageURL: user.imageURL },
    });
  } catch (e) {
    console.log(e);
    res.status(500).json({ error: e.message });
  }
});

export default SignInRouter;
