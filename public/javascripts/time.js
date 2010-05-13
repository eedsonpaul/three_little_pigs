function settime () {
  var curtime = new Date();
  var curhour = curtime.getHours();
  var curmin = curtime.getMinutes();
  var cursec = curtime.getSeconds();
  var time = "";

if(curhour == 0) curhour = 12;
  time = (curhour > 12 ? curhour - 12 : curhour) + ":" +
  (curmin < 10 ? "0" : "") + curmin + ":" +
  (cursec < 10 ? "0" : "") + cursec + " "+
  (curhour > 12 ? "PM" : "AM");
  return time;
}
