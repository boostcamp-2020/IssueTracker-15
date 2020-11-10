const path = require("path");

module.exports = {
  entry: "./src/index.tsx",
  output: {
    publicPath: "/",
    path: path.resolve(__dirname, "dist"),
    filename: "main.js",
  },
  devtool: "source-map",
  resolve: {
    extensions: [".js", ".ts", ".tsx"],
  },
  module: {
    rules: [
      {
        loader: "file-loader",
        test: /\.png?$/,
        options: {
          name: "[name].[ext]?[hash]",
        },
      },
    ],
  },
};
