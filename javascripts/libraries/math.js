// Programmer: Larry Battle
// Date: Mar 06, 2011
// Purpose: Calculate standard deviation, variance, and average among an array of numbers.
var isArray = function(obj) {
    return Object.prototype.toString.call(obj) === "[object Array]";
  },
  round = function(num, numOfDec) {
    var pow10s = Math.pow(10, numOfDec || 0);
    return (numOfDec) ? Math.round(pow10s * num) / pow10s : num;
  },
  getAverageFromNumArr = function(numArr, numOfDec) {
    if (!isArray(numArr)) {
      return false;
    }
    var i = numArr.length,
      sum = 0;
    while (i--) {
      sum += numArr[i];
    }
    return round( (sum / numArr.length), numOfDec);
  },
  getVariance = function(numArr, numOfDec) {
    if (!isArray(numArr)) {
      return false;
    }
    var avg = getAverageFromNumArr(numArr, numOfDec),
      i = numArr.length,
      v = 0;

    while (i--) {
      v += Math.pow( (numArr[i] - avg), 2);
    }
    v /= numArr.length;
    return round(v, numOfDec);
  },
  getStandardDeviation = function(numArr, numOfDec) {
    if (numOfDec == null) {
      numOfDec = 2;
    }
    if (!isArray(numArr)) {
      return false;
    }
    var stdDev = Math.sqrt(getVariance(numArr, numOfDec));
    return round(stdDev, numOfDec);
  };
  
