import React, { useState, Fragment } from "react";
import * as S from "./style";
import Dropdown from "../../../dropdown";
import useToggle from "../../../../hooks/useToggle";
import { BiCaretDown } from "react-icons/bi";

interface FilterListCompProp {
  title: string;
}
function FilterListComp({ title }: FilterListCompProp) {
  const [isOpen, setIsOpen] = useToggle(false);

  const DropdownContents = {
    title: `Filter by ${title}`,
    contents: [],
  };

  return (
    <Fragment>
      <S.FilterListComp onClick={setIsOpen}>
        {title}
        {isOpen && <Dropdown {...DropdownContents} />}
        <BiCaretDown />
      </S.FilterListComp>
    </Fragment>
  );
}

export default FilterListComp;
