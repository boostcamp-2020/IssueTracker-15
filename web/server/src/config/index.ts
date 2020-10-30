import dotenv from "dotenv";

dotenv.config();

const config = {
  DATABASE: {
    DB_HOST: process.env.DB_HOST,
    DB_PORT: process.env.DB_PORT as string,
    DB_USERNAME: process.env.DB_USERNAME as string,
    DB_PASSWORD: process.env.DB_PASSWORD,
    DB_DATABASE: process.env.DB_DATABASE as string,
  },
};

export default config;
