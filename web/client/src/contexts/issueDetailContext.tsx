import React, { useReducer, useContext, createContext, Dispatch } from "react";
import useAsync from "../hooks/useAsync";
import * as api from "../lib/api";

// 상태를 위한 타입
type State = {
  loading: boolean;
  data: null | any;
  error: null | any;
};

// 모든 액션들을 위한 타입
type Action =
  | { type: "FETCH_ISSUE_BY_ID" }
  | { type: "FETCH_ISSUE_BY_ID_SUCCESS"; payload: { data: any } }
  | { type: "FETCH_ISSUE_BY_ID_ERROR"; payload: { error: any } };

// 디스패치를 위한 타입 (Dispatch 를 리액트에서 불러올 수 있음), 액션들의 타입을 Dispatch 의 Generics로 설정
type issueDetailDispatch = Dispatch<Action>;

export const fetchIssueByIdActionGenerator = async (
  id: number,
  dispatch: issueDetailDispatch
) => {
  try {
    dispatch({ type: "FETCH_ISSUE_BY_ID" });
    const data = await api.getIssueById(id);
    dispatch({
      type: "FETCH_ISSUE_BY_ID_SUCCESS",
      payload: { data },
    });
  } catch (error) {
    dispatch({ type: "FETCH_ISSUE_BY_ID_ERROR", payload: { error } });
  }
};

// Context 만들기
const IssueDetailStateContext = createContext<State | null>(null);
const IssueDetailDispatchContext = createContext<issueDetailDispatch | null>(
  null
);

// 리듀서
function reducer(state: State, action: Action): State {
  switch (action.type) {
    case "FETCH_ISSUE_BY_ID":
      return {
        loading: true,
        data: null,
        error: null,
      };
    case "FETCH_ISSUE_BY_ID_SUCCESS":
      return {
        ...state,
        loading: false,
        data: action.payload.data,
      };
    case "FETCH_ISSUE_BY_ID_ERROR":
      return {
        ...state,
        loading: false,
        data: null,
        error: action.payload.error,
      };
    default:
      throw new Error("Unhandled action");
  }
}

// SampleProvider 에서 useReduer를 사용하고
// SampleStateContext.Provider 와 SampleDispatchContext.Provider 로 children 을 감싸서 반환합니다.
export function IssueDetailProvider({
  children,
}: {
  children: React.ReactNode;
}) {
  const [state, dispatch] = useReducer(reducer, {
    loading: false,
    data: null,
    error: null,
  });

  return (
    <IssueDetailStateContext.Provider value={state}>
      <IssueDetailDispatchContext.Provider value={dispatch}>
        {children}
      </IssueDetailDispatchContext.Provider>
    </IssueDetailStateContext.Provider>
  );
}

// state 와 dispatch 를 쉽게 사용하기 위한 커스텀 Hooks
export function useIssueDetailState() {
  const state = useContext(IssueDetailStateContext);
  if (!state) throw new Error("Cannot find SampleProvider"); // 유효하지 않을땐 에러를 발생
  return state;
}

export function useIssueDetailDispatch() {
  const dispatch = useContext(IssueDetailDispatchContext);
  if (!dispatch) throw new Error("Cannot find SampleProvider"); // 유효하지 않을땐 에러를 발생
  return dispatch;
}
