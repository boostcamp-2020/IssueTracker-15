import { createConnection } from "typeorm";

const createDBConnection = (): void => {
  createConnection()
    .then(() => {
      console.log("✌️ Database Connected");
    })
    .catch((err) => console.log(err));
};

export default createDBConnection;
