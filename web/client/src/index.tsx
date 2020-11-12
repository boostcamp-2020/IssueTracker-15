import React from "react";
import ReactDOM from "react-dom";
import { BrowserRouter } from "react-router-dom";
import App from "./app";
import { IssueDetailProvider } from "./contexts/issueDetailContext";

ReactDOM.render(
  <BrowserRouter>
    <IssueDetailProvider>
      <App />
    </IssueDetailProvider>
  </BrowserRouter>,
  document.getElementById("root")
);
