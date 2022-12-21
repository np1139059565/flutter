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

    console.info(request.url, params);

    let timeFilter = '';

    if (msg != '') {
        return response.writo(500, msg);
    }
    const sql1 = "SELECT COUNT(1) FROM order_job A LEFT JOIN all_job B on A.job_id=B.id WHERE B.uid=" + params.uid +
        " AND UNIX_TIMESTAMP(now())-UNIX_TIMESTAMP(A.order_time)<B.max_used_seconds;";
    const sql2 = "SELECT SLEEP(1);";
    mdb.query(sql1 + sql2, (e, r, f) => {
        if (e) {
            const msg = '  sql is err!';
            console.info(msg, e);
            return response.writo(500, msg);
        }
        response.writo(200, JSON.stringify({ count: r[0][0][f[0][0].name] }));
    });
}
exports.get = _get
