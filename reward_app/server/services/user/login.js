const md5 = require('md5-node');

let mdb = require("../../common/export_mdb");
const mtime = require('../../common/export_mtime');
function _get(request, response) {
    const params = Object.fromEntries(request.url.indexOf('?') < 0 ? [] : request.url.split('?')[1].split('&').map(kv => kv.split('=')));
    let msg = '';
    if ((parseInt(params.uid) >= 0) == false) {
        return response.writo(500, 'sql attack!');
    }

    console.info(request.url, params);
    const sql = "select user,pwd from all_user where uid=" + params.uid;
    mdb.query(sql, (e, r, f) => {
        if (e) {
            const msg = '  sql is err!';
            console.info(msg, e);
            return response.writo(500, msg);
        }

        const user = r[0][f[0].name];
        const pwd = r[0][f[1].name];
        const session = mtime.getSeconds();
        const encode = md5(params.uid + ':' + user + ':' + pwd + ':' + session);
        response.writo(encode == params.key ? 200 : 500, JSON.stringify({ session: session, encode: encode, msg: msg }));
    });
}
exports.get = _get
