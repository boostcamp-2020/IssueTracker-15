import React from "react";
import { Redirect, Route, Switch } from "react-router-dom";
import CreateIssuePage from "./views/create-issue";
import CreateMilestonePage from "./views/create-milestone";
import DetailIssuePage from "./views/detail-issue/index";
import IssuePage from "./views/issue";
import LabelPage from "./views/label";
import MilestonePage from "./views/milestone";
import Header from "./components/header";
import { Reset } from "styled-reset";
import Callback from "./components/auth/callback";

const App = () => {
  return (
    <>
      <Reset />
      <Header />
      <Switch>
        <Route path="/milestone/new" component={CreateMilestonePage} />
        <Route path="/milestone" component={MilestonePage} />
        <Route path="/label" component={LabelPage} />
        <Route path="/issue/new" component={CreateIssuePage} />
        <Route path="/issue/:id" component={DetailIssuePage} />
        <Route path="/issue" component={IssuePage} />
        <Route path="/auth/github" component={Callback} />
        <Redirect from="*" to="/issue" />
      </Switch>
    </>
  );
};

export default App;
