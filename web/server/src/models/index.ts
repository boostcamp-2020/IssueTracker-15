import { Sequelize } from "sequelize";
import config from "../config";

export const sequelize = new Sequelize(
  config.DATABASE.DB_DATABASE,
  config.DATABASE.DB_USERNAME,
  config.DATABASE.DB_PASSWORD,
  {
    host: config.DATABASE.DB_HOST,
    dialect: "mysql",
    define: {
      paranoid: true,
    },
    timezone: "+09:00",
  }
);

sequelize
  .authenticate()
  .then(() => {
    console.log("Connection has been established successfully.");
  })
  .catch((err) => {
    console.error("Unable to connect to the database:", err);
  });
