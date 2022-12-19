console.info("  boot is init..");
let http = require("http");

function writo(response, code, conter) {
  response.writeHead(code, {
    "Content-Type": "application/json",//https://blog.csdn.net/chengp919/article/details/78105602/
    "Access-Control-Allow-Origin": "*"//解决浏览器调试时的跨域问题https://blog.csdn.net/weixin_38587278/article/details/108372889
  });
  response.write(conter);
  response.end();
}

function getContTypeByFileName(fileName) {
  const imageTypes = ["GIF", "PNG", "JPG", "JPEG", "ICO"];
  const suffix = fileName.split(".").reverse()[0].toUpperCase();
  var contType = null;
  if (imageTypes.indexOf(suffix) >= 0) {
    contType = "image/" + suffix;
  }
  const textTypes = ["HTML", "PLAIN", "XML"];
  if (textTypes.indexOf(suffix) >= 0) {
    contType = "text/" + suffix;
  }
  return contType;
}

function handFile(request, response) {
  const filePath = "../web/" + request.url.substr(1);
  contType = getContTypeByFileName(filePath);
  if (contType) {
    let fs = require("fs");
    fs.readFile(filePath, function (e, d) {
      if (e) {
        console.info("  boot not find web file..", e);
        response.writo(404, "file not find!");
      } else {
        let stream = fs.createReadStream(filePath);
        if (stream) {
          let respData = [];
          stream.on("data", function (chunk) {
            respData.push(chunk);
          });
          stream.on("end", function () {
            let finalData = Buffer.concat(respData);
            response.writeHead(200, {
              "Content-Type": contType
            });
            response.write(finalData);
            response.end();
          });
        } else {
          console.error("  boot create stream is fail!");
          response.writo(500, "server is err!");
        }
      }
    });
    return true
  } else return false
}

function handService(request, response) {
  var handMethod;
  try {
    handMethod = require("./services/" + request.url.substr(1).split("?")[0]);
  } catch (e) {
    const msg = '  not find serivces..';
    console.info(msg, e);
    return writo(response, 404, msg);
  }
  var conter;
  switch (request.method) {
    case "GET":
      conter = handMethod.get(request, response);
      break;
    case "POST":
      conter = handMethod.post(request, response);
      break;
  }
  if (conter) writo(response, 200, conter);
}

http.createServer(function (request, response) {
  try {
    console.info("  boot listen..", request.url, request.method);
    response.writo = (code, conter) => writo(response, code, conter);
    let handFileBool = handFile(request, response);
    if (!handFileBool) {
      handService(request, response);
    }
  } catch (e) {
    const msg = '  Server is err!'
    console.error(msg, e);
    writo(response, 500, msg);
  }
}).listen(8888);
