import * as Sequelize from "sequelize";

export default (
  sequelize: Sequelize.Sequelize,
  DataTypes: Sequelize.DataTypes
) => {
  return sequelize.define("User", {
    id: {
      type: DataTypes,
      autoIncrement: true,
      allowNull: false,
      primaryKey: true,
    },
    email: {
      type: DataTypes.STRING,
    },
  });
};
