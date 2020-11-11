import express, { Request, Response } from "express";
import UserService from "../services/user.service";

const UserRouter = express.Router();

UserRouter.get("/", async (req: Request, res: Response) => {
  try {
    const userList = await UserService.getUserList();
    res.json(userList);
  } catch (err) {
    return res.status(400).json({ message: err.message });
  }
});

export default UserRouter;
