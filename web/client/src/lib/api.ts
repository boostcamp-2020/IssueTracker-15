import { PostLabel } from "../@types/label-form";

const URL = "http://118.67.134.194:3000";

export const getLabels = async () => {
  const result = await fetch(`${URL}/api/label`, {
    method: "GET",
  });
  if (!result.ok) return false;

  return await result.json();
};

export const postNewLabel = async (label: PostLabel) => {
  const result = await fetch(`${URL}/api/label`, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify({ ...label }),
  });
  if (!result.ok) return false;

  return await result.json();
};

export const deleteLabelReqeust = async (labelId: number) => {
  const result = await fetch(`${URL}/api/label/${labelId}`, {
    method: "DELETE",
  });
  return result;
};

export const getJWTToken = async (code: string) => {
  const result = await fetch(`${URL}/api/signin/github`, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify({
      code,
    }),
  });
  const { accessToken } = await result.json();
  return accessToken;
};
