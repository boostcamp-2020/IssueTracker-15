import { createConnection } from "typeorm";

export const createDBConnection = () => {
  createConnection()
    .then(() => {
      console.log("✌️ Database Connected");
    })
    .catch((err) => console.log(err));
};
