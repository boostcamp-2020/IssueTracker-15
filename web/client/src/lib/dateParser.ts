export const getTimeTillNow = (time: string): string => {
  const now = new Date();
  const fromTime = new Date(time);


  const minutesTillNow = parseInt(((now.getTime() - fromTime.getTime()) / (1000 * 60) ).toString());
  if(minutesTillNow < 60) return minutesTillNow.toString() + ' minutes';

  const hoursTillNow = minutesTillNow / 60;
  if(hoursTillNow < 24) return parseInt(hoursTillNow.toString()).toString() + ' hours';

  const daysTillNow = now.getDay() - fromTime.getDay();
  if(daysTillNow < 31) return parseInt(daysTillNow.toString()).toString() + ' days';

  const monthsTillNow = daysTillNow / 30;
  if(monthsTillNow < 12) return parseInt(monthsTillNow.toString()).toString() + ' months';

  const yearsTillNow = monthsTillNow / 12;
  return parseInt(yearsTillNow.toString()).toString() + 'years';
}