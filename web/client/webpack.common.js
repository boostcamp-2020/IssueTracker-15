const HtmlWebpackPlugin = require("html-webpack-plugin");
const webpack = require("webpack");
const path = require("path");
const isProduction = process.env.NODE_ENV === "PRODUCTION";
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
        test: /\.tsx?$/,
        use: [
          {
            loader: "ts-loader",
            options: {
              // true 로 설정하면 typeCheck x , false 로 설정하면 typeCheck o
              transpileOnly: isProduction ? true : false,
            },
          },
        ],
      },
      {
        loader: "file-loader",
        test: /\.png?$/,
        options: {
          name: "[name].[ext]?[hash]",
        },
      },
    ],
  },

  plugins: [
    new webpack.ProvidePlugin({ React: "react" }),
    new webpack.HotModuleReplacementPlugin(),
    new HtmlWebpackPlugin({
      minify: isProduction
        ? {
            collapseWhitespace: true,
            useShortDoctype: true,
            removeScriptTypeAttributes: true,
          }
        : false,
      template: "./src/index.html",
      filename: "index.html",
    }),
    new webpack.DefinePlugin({
      IS_PRODUCTION: isProduction,
    }), // IS_PRODUCTION 변수 쓸 수 있게 해줌.
  ],
};
