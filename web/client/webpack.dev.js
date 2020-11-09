const { merge } = require("webpack-merge");
const path = require("path");

const common = require("./webpack.common");
const config = {
  mode: "development",

  devServer: {
    contentBase: "./dist/",
    historyApiFallback: true,
    open: true,
  },
};
module.exports = merge(common, config);
