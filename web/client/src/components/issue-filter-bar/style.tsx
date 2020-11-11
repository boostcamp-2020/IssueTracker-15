import styled from "styled-components";
import { Link } from "react-router-dom";

export const FilterBar = styled.div`
  width: 98%;
  display: flex;
  margin: 1%;
  justify-content: space-between;
  align-items: flex-start;
`;

export const FilterWrapper = styled.div`
  width: 12%;
  border-right: 1px solid #ced4da;
  position: relative;
`;

export const FilterForm = styled.div`
  width: 100%;
  padding-left: 15%;
  display: flex;
`;

export const FilterComp = styled.div`
  align-self: center;
  font-weight: bold;
`;

export const SearchForm = styled.div`
  width: 70%;

  padding-left: 2%;
  color: #586069;
`;

export const FilterContainer = styled.div`
  padding-top: 0.35rem;
  padding-bottom: 0.35rem;
  width: 60%;
  border: 1px solid #ced4da;
  align-items: center;
  border-radius: 6px;
  background-color: #fafbfc;
  color: #24292e;
  display: flex;
`;

export const MilestoneLink = styled(Link)`
  text-decoration: none;
  display: flex;
  justify-contents: center;
  width: 15%;
`;

export const LabelLink = styled(Link)`
  text-decoration: none;
  justify-contents: center;
  width: 10%;
`;
