var http = require("http");

function onResponse(request, response) {
    response.setHeader("Content-Type", "text/html; charset=utf-8");
    response.writeHead(200, {"Content-Type": "text/plain"});
    response.end("Ahoj :)");
}

var server = http.createServer(onResponse);
server.listen(9233);

console.log("Server running at http://127.0.0.1:9233/");