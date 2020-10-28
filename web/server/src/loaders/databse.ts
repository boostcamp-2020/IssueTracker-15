import { createConnection } from "typeorm";

export const createDBConnection = () => {
  createConnection()
    .then(() => {
      console.log("연결완료");
    })
    .catch((err) => console.log(err));
};
