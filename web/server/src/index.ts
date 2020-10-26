import express, { NextFunction, Request, Response } from "express";

const app = express();

app.use("/", (req: Request, res: Response, next: NextFunction) => {
  res.send("hello");
});

const port = 3000;
app.listen(port, () => {
  console.log("listening in 3000");
});
