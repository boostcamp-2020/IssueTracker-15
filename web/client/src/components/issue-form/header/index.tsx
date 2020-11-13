import React, { useState, useEffect } from "react";
import * as S from "./style";
import FilterListComp from "./filter-list-content";
import { getMilestones } from "../../../lib/api";
import MilestoneProp from "../../../@types/milestone";

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
      const newMilestonesTitle = newMilestones.map(
        (milestone: MilestoneProp) => milestone.title
      );
      setMilestones(newMilestonesTitle);
    };
    const result = getMilestones();
  }, []);
  return (
    <S.IssueHeader>
      <input type="checkbox" name="xxx" value="yyy" />
      <S.FilterList>
        {FilterTitles.map((filterTitle, idx) => {
          return (
            <FilterListComp key={idx} title={filterTitle}></FilterListComp>
          );
        })}
      </S.FilterList>
    </S.IssueHeader>
  );
}

export default issueHeader;
