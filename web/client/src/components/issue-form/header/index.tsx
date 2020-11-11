import React, { useState, useEffect } from "react";
import * as S from "./style";
import FilterListComp from "./filter-list-content";
import { getMilestones } from "../../../lib/api";
const FilterTitles = [
  "Author",
  "Label",
  "Projects",
  "Milestones",
  "Assignee",
  "sort",
];

function issueHeader() {
  const [milestones, setMilestones] = useState([]);

  useEffect(() => {
    const fetchMilestones = async () => {
      const newMilestones = await getMilestones();
      const newMilestonesTitle = newMilestones.map((milestone: any) => {
        return milestone.title;
      });
      setMilestones(newMilestonesTitle);
    };
    const result = getMilestones();
  }, []);
  return (
    <S.IssueHeader>
      <input type="checkbox" name="xxx" value="yyy" checked />
      <S.FilterList>
        {FilterTitles.map((filterTitle) => {
          return <FilterListComp title={filterTitle}></FilterListComp>;
        })}
      </S.FilterList>
    </S.IssueHeader>
  );
}

export default issueHeader;
