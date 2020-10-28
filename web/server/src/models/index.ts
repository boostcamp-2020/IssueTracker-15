import { Sequelize } from "sequelize";
import config from "../config";

export const DB = new Sequelize(
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
