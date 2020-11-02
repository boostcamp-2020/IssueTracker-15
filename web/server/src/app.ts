import express from "express";
import loaders from "./loaders";


const app = express();
loaders(app);


app.listen(3000, () => {
  console.log(`💌 Listening on port : 3000`);
});

export default app;
