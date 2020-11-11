const URL = "http://118.67.134.194:3000";

export const getLabels = async () => {
  const result = await fetch(`${URL}/api/label`, {
    method: "GET",
  });
  if (!result.ok) return;

  const labelList = await result.json();
  return labelList;
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
