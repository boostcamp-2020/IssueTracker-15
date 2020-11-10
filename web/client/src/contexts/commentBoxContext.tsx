// import { createContext, useReducer, useContext } from "react";

// // 상태전용 Context
// const TodosStateContext = createContext(undefined);

// // Dispatch 전용 Context
// const TodosDispatchContext = createContext(undefined);

// // 리듀서
// function todosReducer(state, action) {
//   switch (action.type) {
//     case "CREATE":
//       const nextId = Math.max(...state.map((todo) => todo.id)) + 1;
//       return state.concat({
//         id: nextId,
//         text: action.text,
//         done: false,
//       });
//     case "TOGGLE":
//       return state.map((todo) =>
//         todo.id === action.id ? { ...todo, done: !todo.done } : todo
//       );
//     case "REMOVE":
//       return state.filter((todo) => todo.id !== action.id);
//     default:
//       throw new Error("Unhandled action");
//   }
// }

// // Context Provider
// export function TodosContextProvider({ children }) {
//   const [todos, dispatch] = useReducer(todosReducer, [
//     {
//       id: 1,
//       text: "Context API 배우기",
//       done: true,
//     },
//     {
//       id: 2,
//       text: "TypeScript 배우기",
//       done: true,
//     },
//     {
//       id: 3,
//       text: "TypeScript 와 Context API 함께 사용하기",
//       done: false,
//     },
//   ]);

//   return (
//     <TodosDispatchContext.Provider value={dispatch}>
//       <TodosStateContext.Provider value={todos}>
//         {children}
//       </TodosStateContext.Provider>
//     </TodosDispatchContext.Provider>
//   );
// }

// // 커스텀 Hooks
// export function useTodosState() {
//   const state = useContext(TodosStateContext);
//   if (!state) throw new Error("TodosProvider not found");
//   return state;
// }

// export function useTodosDispatch() {
//   const dispatch = useContext(TodosDispatchContext);
//   if (!dispatch) throw new Error("TodosProvider not found");
//   return dispatch;
// }
