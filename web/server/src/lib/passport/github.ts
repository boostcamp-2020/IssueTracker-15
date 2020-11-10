const passport = require("passport");
const GitHubStrategy = require("passport-github2").Strategy;

passport.serializeUser(function (user: any, done: any) {
  done(null, user);
});
passport.deserializeUser(function (user: any, done: any) {
  done(null, user);
});

const gitHubConfig = {
  clientID: "bbd8f4faffe4f6f9c9b7",
  clientSecret: process.env.CLIENT_SECRET,
  callbackURL: "http://localhost:8080/auth/github",
};
const passportVerify = (
  accessToken: string,
  refreshToken: string,
  profile: any,
  done: any
) => {
  return done(null, profile);
};

const github = () => {
  passport.use(new GitHubStrategy(gitHubConfig, passportVerify));
};

export default github;
