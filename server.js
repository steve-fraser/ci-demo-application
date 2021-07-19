'use strict';

const express = require('express');
var path = require('path');

// Constants
const PORT = 3000;
const HOST = '0.0.0.0';

// App
const app = express();

app.use(express.urlencoded({
    extended: true
}))
app.engine('html', require('ejs').renderFile);

app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname + '/index.html'));
      
});

app.post('/submit', function (req, res) {
    var numberOfChucks = req.body.numberOfChucks;
    res.render(__dirname + "/index.html", { numberOfChucks: numberOfChucks });
})

app.listen(PORT, HOST);
module.exports = app;
console.log(`Running on http://${HOST}:${PORT}`);