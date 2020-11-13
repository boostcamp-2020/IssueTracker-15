import React, { Dispatch, SetStateAction, useCallback, useState } from "react";
import * as S from "./style";
import Button from "../../components/button";
import LabelCreateBox from "../label-create-box";
import NavButton from "../../components/nav-button";

export interface LabelContextProps {
  createLabelVisible: boolean;
  setCreateLabel?: Dispatch<SetStateAction<boolean>>;
}

export const LabelHeaderContext = React.createContext({} as LabelContextProps);

export default function LabelListHeader() {
  const [createLabelVisible, setCreateLabel] = useState(false);

  const toggleCreateLabel = useCallback(() => {
    setCreateLabel(!createLabelVisible);
  }, [createLabelVisible]);

  return (
    <LabelHeaderContext.Provider value={{ createLabelVisible, setCreateLabel }}>
      <S.LabelListHeaderWrapper>
        <S.LabelListHeader>
          <Button color="green" onClick={toggleCreateLabel}>
            New Label
          </Button>
        </S.LabelListHeader>
        <LabelCreateBox />
      </S.LabelListHeaderWrapper>
    </LabelHeaderContext.Provider>
  );
}
