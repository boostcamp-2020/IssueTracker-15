const URL = "http://118.67.134.194:3000";

export const getLabels = async () => {
  const result = await fetch(`${URL}/api/label`, {
    method: "GET",
  });
  if (!result.ok) return;

  const labelList = await result.json();
  return labelList;
};
