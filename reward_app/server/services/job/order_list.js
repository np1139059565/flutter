let mdb = require("../../common/export_mdb");
const sqlAttack = require('../../common/export_sqlattack');

function _get(request, response) {
    const params = Object.fromEntries(request.url.indexOf("?") < 0 ? [] : request.url.split("?")[1].split("&").map(kv => kv.split("=")));
    if (params.search == null) {
        params.search = "";
    }
    let msg = '';
    if ((params.uid >= 0) == false) {
        msg = 'uid is not find!';
    }
    if ((params.page >= 0 || params.page < 0) == false) {
        params.page = 1;
    }
    if ((params.page_size >= 0 || params.page_size < 0) == false) {
        params.page_size = 5;
    }
    console.info(request.url, params);

    const statusArr = ['未提交', '审核中', '已通过', '未通过'];
    let timeFilter = '';
    const useTimeOrder = 'UNIX_TIMESTAMP(now())-UNIX_TIMESTAMP(A.order_time)';
    if (params.status < statusArr.length && params.status >= 0) {
        timeFilter = statusArr.indexOf(params.status) != statusArr.indexOf('已通过') ? 'AND ' + useTimeOrder + '<B.max_used_seconds' : '';
        params.status = statusArr[params.status];
        //时间直接相减是有问题的,需要转成整数https://www.cnblogs.com/zhenxing/p/16355843.html
    } else {
        params.status = statusArr.join('\',\'');
    }
    if (msg != '') {
        return response.writo(500, msg);
    }
    const minIndex = (params.page - 1) * params.page_size;
    const maxIndex = params.page * params.page_size;
    const sql1 = "SELECT B.*,A.*,DATE_FORMAT(A.order_time,'%Y-%m-%d %H:%i:%s') AS order_time FROM order_job A LEFT JOIN all_job B on A.job_id=B.id WHERE B.uid=" + params.uid +
        " AND A.job_status in ('" + params.status + "') " + timeFilter +
        " ORDER BY " + useTimeOrder + " DESC LIMIT " + minIndex + "," + maxIndex + ";";
    const sql2 = "SELECT COUNT(1) FROM order_job A LEFT JOIN all_job B on A.job_id=B.id WHERE B.uid=" + params.uid +
        " AND A.job_status in ('" + params.status + "') " + timeFilter + ";";
    const sql3 = "SELECT SLEEP(1);";
    mdb.query(sql1 + sql2 + sql3, (e, r, f) => {
        if (e) {
            const msg = '  sql is err!';
            console.info(msg, e);
            return response.writo(500, msg);
        }
        const count = r[1][0][f[1][0].name];
        const maxPage = parseInt(count / params.page_size) + (count % params.page_size > 0 ? 1 : 0);
        response.writo(200, JSON.stringify({ data: r[0], page: params.page, maxPage: maxPage }));
    });
}
exports.get = _get
