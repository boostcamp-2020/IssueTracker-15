import { getConnection } from "typeorm";

const disconnectDB = async (): Promise<void> => {
  const connection = await getConnection();
  await connection.close();
};

export default disconnectDB;
