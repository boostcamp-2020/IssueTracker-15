const HtmlWebpackPlugin = require("html-webpack-plugin");
const { merge } = require("webpack-merge");
const common = require("./webpack.common");
const config = {
  mode: "production",

  module: {
    rules: [
      {
        test: /\.tsx?$/,
        use: [
          {
            loader: "ts-loader",
            options: {
              // true 로 설정하면 typeCheck x , false 로 설정하면 typeCheck o
              transpileOnly: true,
            },
          },
        ],
      },
    ],
  },
  plugins: [
    new HtmlWebpackPlugin({
      minify: {
        collapseWhitespace: true,
        useShortDoctype: true,
        removeScriptTypeAttributes: true,
      },
      template: "./src/index.html",
      filename: "index.html",
    }),
  ],
};
module.exports = merge(common, config);
