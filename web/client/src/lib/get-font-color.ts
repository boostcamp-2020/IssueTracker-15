const getFontColor = (color: string) => {
  const redValue = parseInt(color.substring(1, 3), 16);
  const greenValue = parseInt(color.substring(3, 5), 16);
  const blueValue = parseInt(color.substring(5, 7), 16);
  const result =
    (redValue * 0.299 + greenValue * 0.587 + blueValue * 0.114) / 255;
  if (result >= 0.5) return "black";
  else return "white";
};

export default getFontColor;
