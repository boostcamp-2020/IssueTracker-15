import express from "express";
import loaders from "./loaders";

const startServer = () => {
  const app = express();
  loaders(app);
  app.listen(4000, () => {
    console.log(`💌 Listening on port : 4000`);
  });
};

startServer();
