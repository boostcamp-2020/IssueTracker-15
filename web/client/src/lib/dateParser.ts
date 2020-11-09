export const getTimeTillNow = (time: string): string => {

  enum Time {
    MILLISECONDS_PER_SECOND = 1000,
    SECONDS_PER_MINUTE = 60,
    MINUTES_PER_HOUR = 60,
    HOURS_PER_DAY = 24,
    DAYS_PER_MONTH = 30,
    MONTHES_PER_YEAR = 12
  }

  const now = new Date();
  const fromTime = new Date(time);

  const minutesTillNow = parseInt(((now.getTime() - fromTime.getTime()) / (Time.MILLISECONDS_PER_SECOND * Time.SECONDS_PER_MINUTE) ).toString());
  if(minutesTillNow < Time.MINUTES_PER_HOUR) return minutesTillNow.toString() + ' minutes';

  const hoursTillNow = minutesTillNow / Time.MINUTES_PER_HOUR;
  if(hoursTillNow < Time.HOURS_PER_DAY) return parseInt(hoursTillNow.toString()).toString() + ' hours';

  const daysTillNow = now.getDate() - fromTime.getDate();
  if(daysTillNow <= Time.DAYS_PER_MONTH) return parseInt(daysTillNow.toString()).toString() + ' days';

  const monthsTillNow = daysTillNow / Time.DAYS_PER_MONTH;
  if(monthsTillNow < Time.MONTHES_PER_YEAR) return parseInt(monthsTillNow.toString()).toString() + ' months';

  const yearsTillNow = monthsTillNow / Time.MONTHES_PER_YEAR;
  return parseInt(yearsTillNow.toString()).toString() + 'years';
}