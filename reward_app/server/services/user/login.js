const md5 = require('md5-node');

let mdb = require("../../common/export_mdb");
const mtime=require('../../common/export_mtime');
function _get(request, response) {
    const params = Object.fromEntries(request.url.indexOf('?') < 0 ? [] : request.url.split('?')[1].split('&').map(kv => kv.split('=')));
    let msg = 'service is err!';
    if (parseInt(params.uid) > 0) {
        msg = 'uid is not find!';
    }
    if (params.key == null) {
        msg = 'key is fail!';
    }
    console.info(request.url, params);
    const sql = "select user,pwd from all_user where uid=" + params.uid;
    mdb.query(sql, (e, r, f) => {
        if (e) {
            console.info('list query is err..', e);
            return response.writo(500, 'sql err!');
        }

        const user=r[0][f[0].name];
        const pwd=r[0][f[1].name];
        const session=mtime.getSeconds();
        const encode=md5(params.uid+':'+user+':'+pwd+':'+session);
        response.writo(encode==params.key?200:500, JSON.stringify({ session: session,encode:encode}));
    });
}
exports.get = _get
