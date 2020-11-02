module.exports = {
  preset: "ts-jest",
  testEnvironment: "node",
  transform: {
    "^.+\\.ts$": "ts-jest",
  },
  testRegex: "\\.test\\.ts$",
  moduleFileExtensions: ["ts", "js"],
  globals: {
    "ts-jest": {
      diagnostics: true,
    },
  },
};
