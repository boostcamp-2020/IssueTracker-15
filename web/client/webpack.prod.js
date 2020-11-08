const { merge } = require("webpack-merge");
const common = require("./webpack.common");
const config = {
  mode: "production",
};
module.exports = merge(common, config);
