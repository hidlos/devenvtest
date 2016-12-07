var http = require("http");

function onResponse(request, response)
{
    response.setHeader("Content-Type", "text/html; charset=utf-8");
    response.end("Ahoj :)");
}

var server = http.createServer(onResponse);
server.listen(80);