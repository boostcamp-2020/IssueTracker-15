import React from "react";
import LabelRowContainer from "../../containers/label-row-container";
import LabelListHeader from "../../containers/label-list-header";

interface LabelContextProps {
  createToggle: boolean;
}

export const LabelContext = React.createContext({} as LabelContextProps);

const LabelPage = () => {
  return (
    <LabelContext.Provider value={{ createToggle: false }}>
      <LabelListHeader />
      <LabelRowContainer />
    </LabelContext.Provider>
  );
};

export default LabelPage;
