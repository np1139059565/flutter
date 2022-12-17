function _getSeconds(){
  return (new Date().getTime()/1000).toString().split('.')[0];
}
module.exports.getSeconds=_getSeconds
