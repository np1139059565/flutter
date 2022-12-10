let mdb=require("../../common/export_mdb");
function _get(request,response){
  const params=Object.fromEntries(request.url.indexOf("?")<0?[]:request.url.split("?")[1].split("&").map(kv=>kv.split("=")));
  if(params.search==null){
    params.search="";
  }
  if(params.page==null){
    params.page=1;
  }
  if(params.page_size==null){
    params.page_size=5;
  }
  console.info(request.url,params);
  const minIndex=(params.page-1)*params.page_size;
  const maxIndex=params.page*params.page_size;
  const sql1="select * from all_job where id like '%"+params.search+"%' LIMIT "+minIndex+","+maxIndex+";";
  const sql2="SELECT COUNT(1) FROM all_job where id like '%"+params.search+"%';";
  const sql3="SELECT sleep(1);";
  mdb.query(sql1+sql2+sql3,(e,r,f)=>{
    if(e)return response.write(500,e);
    const count=r[1][0][f[1][0].name];
    const maxPage=parseInt(count/params.page_size)+(count%params.page_size>0?1:0);
    response.writo(200,JSON.stringify({data:r[0],page:params.page,maxPage:maxPage}));
  });
}
exports.get=_get
