var express  = require("express"),
    http     = require('http'),
    mongoose = require("mongoose");
    
http.createServer(function (req, res) {
    res.writeHead(200, {'Content-Type': 'text/plain'});
    res.end('Hello World\n');
}).listen(process.env.PORT, process.env.IP);