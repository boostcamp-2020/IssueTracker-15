import React from 'react';
import { Redirect, Route, Switch } from 'react-router-dom';
import { Reset } from 'styled-reset';
import Commentbox from './components/commentBox/CommentBox';
import IssueHeader from './components/IssueHeader/IssueHeader';
import CreateIssuePage from './views/create-issue';
import CreateMilestonePage from './views/create-milestone';
import DetailIssuePage from './views/detail-issue';
import IssuePage from './views/issue';
import LabelPage from './views/label';
import MilestonePage from './views/milestone';

const App = () => {
  return (
    <Switch>
      <Route path="/milestone/new" component={CreateMilestonePage} />
      <Route path="/milestone" component={MilestonePage} />
      <Route path="/label" component={LabelPage} />
      <Route path="/issue/new" component={CreateIssuePage} />
      <Route path="/issue/:id" component={DetailIssuePage} />
      <Route path="/issue" component={IssuePage} />
      <Redirect from="*" to="/issue" />
    </Switch>
  );
};

export default App;
