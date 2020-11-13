export const isValidColor = (color: string) => {
  const reg = /^#[0-9A-F]{6}$/i;
  const result = reg.exec(color);
  if (result === null) return false;
  return true;
};

export const getRandomColor = (): any => {
  const color = `#${Math.round(Math.random() * 0xffffff).toString(16)}`;
  const isValid = isValidColor(color);
  if (isValid) return color;
  return getRandomColor();
};
