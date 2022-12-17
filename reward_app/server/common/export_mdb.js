console.info("  common.mdb is init..");
const mysql=require("mysql");
const pool=mysql.createPool({
    connectionLimit:1,
    multipleStatements:true,
    host     : 'localhost',
    user     : 'root',
    password : '3375863936lcy',
    database : 'reward_app'
  });
console.info(pool);
function getConn(){
  return pool.get().disposer(function(conn){
    pool.releaseConnection(conn);
  });
}

function _query(sql,callback){
  console.info("  common.query sql is",sql);
  var qr=[];
  pool.query(sql,(e,r,f)=>{
    if(e)console.error("  common.query is err",e);
    if(callback)callback(e,r,f);
    //return [r];
  });//.then((d)=>{
    //getConn().query("select 1",(e,r,f)=>{
      //if(e)console.error("  ccccccccccccc",e);
      //console.info("jjjjjjjjjjj",d,e,r,f);
      //callback(e,[d,r],f);
    //});
  //});
}

module.exports.query=_query;
module.exports.fieldToArr=(fields)=>fields.map((f)=>f.name);
