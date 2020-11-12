import React, { useReducer, useContext, createContext, Dispatch } from "react";
import * as api from "../lib/api";
import createActionDispatcher from "../lib/asyncActionUtils";
import { createAsyncHandler, initialAsyncState } from "../lib/asyncActionUtils";

const IssueDetailStateContext = createContext<any>(null);
const IssueDetailDispatchContext = createContext<Dispatch<any> | undefined>(
  undefined
);

const initialState = {
  issue: initialAsyncState,
};

const fakeComment = {
  id: 3,
  content: "###안녕하세요",
  createAt: "2020-11-02T14:26:16.241Z",
  user: {
    id: 1,
    userName: "namda",
    imageURL: "https://avatars3.githubusercontent.com/u/60877502?v=4",
  },
};

export const getIssueById = createActionDispatcher(
  "GET_ISSUE_BY_ID",
  api.getIssueById
);

export const addComment = (comment: any, dispatch: any) => {
  dispatch({ type: "ADD_COMMENT", payload: { comment } });
};

const issueHandler = createAsyncHandler("GET_ISSUE_BY_ID", "issue");

export function IssueDetailProvider({
  children,
}: {
  children: React.ReactNode;
}) {
  // 위에서 만든 객체 / 유틸 함수들을 사용하여 리듀서 작성
  function reducer(state: any, action: any) {
    switch (action.type) {
      case "GET_ISSUE_BY_ID":
      case "GET_ISSUE_BY_ID_SUCCESS":
      case "GET_ISSUE_BY_ID_ERROR":
        return issueHandler(state, action);
      case "ADD_COMMENT":
        return {
          ...state,
          issue: {
            ...state.issue,
            data: {
              ...state.issue.data,
              comments: [
                ...state.issue.data.comments,
                {
                  ...fakeComment,
                  content: action.payload.comment.content,
                  createAt: new Date().toString(),
                },
              ],
            },
          },
        };
      default:
        throw new Error(`Unhanded action type: ${action.type}`);
    }
  }

  const [state, dispatch] = useReducer(reducer, initialState);

  return (
    <IssueDetailStateContext.Provider value={state}>
      <IssueDetailDispatchContext.Provider value={dispatch}>
        {children}
      </IssueDetailDispatchContext.Provider>
    </IssueDetailStateContext.Provider>
  );
}

export function useIssueDetailState() {
  const state = useContext(IssueDetailStateContext);
  if (!state) throw new Error("Cannot find SampleProvider");
  return state;
}

export function useIssueDetailDispatch() {
  const dispatch = useContext(IssueDetailDispatchContext);
  if (!dispatch) throw new Error("Cannot find SampleProvider");
  return dispatch;
}
