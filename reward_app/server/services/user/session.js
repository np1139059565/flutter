
const mtime = require('../../common/export_mtime');

function _get(request, response) {
    response.writo(200, mtime.getSeconds());
}
exports.get = _get
