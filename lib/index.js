var express = require('express');  
var app = express();  
var bodyParser = require('body-parser');  
var urlencodedParser = bodyParser.urlencoded({ extended: false })
var multer = require('multer');
var upload = multer(); 
var mongo = require('mongodb');
var license;
var MongoClient = require('mongodb').MongoClient;
var { query, response, json } = require('express');
var url = "mongodb://localhost:27017/mydb";

//add notes
app.use(express.static('public'));          
app.post('/addnotes',urlencodedParser, function (req, res) {  
const now = new Date();
const year = now.getFullYear();
const month = ("0" + (now.getMonth() + 1)).slice(-2);
const day = ("0" + now.getDate()).slice(-2);

const hour = ("0" + now.getHours()).slice(-2);
const minute = ("0" + now.getMinutes()).slice(-2);
const second = ("0" + now.getSeconds()).slice(-2);

// YYYY-MM-DD hh:mm:ss
const date = `${year}-${month}-${day}`
const time=  `${hour}:${minute}:${second}`
console.log(date)
   MongoClient.connect(url, function(err, db) {
  if (err) throw err;
  var dbo = db.db("mydb");
  var myobj = {
     date:date,
     title:req.body.title,
     content:req.body.content,
     time:time
    
      };
     console.log(myobj);
  dbo.collection("notes").insertOne(myobj, function(err, res) {
    if (err) throw err;
      db.close();
  });
});
})
//view all notes
app.use(express.static('public'));              //product list
app.post('/viewallnotes', urlencodedParser, function (req, res) {
  MongoClient.connect(url, function (err, db) {
    if (err) throw err;
    var dbo = db.db("mydb");
    dbo.collection("notes").find().toArray(function (err, n) {
      if (err) throw err;
      res.send(n);
      db.close();
    });

  });
})
//delete notes
app.post('/delete', urlencodedParser, function (req, res) {

  MongoClient.connect(url, function (err, db) {
    if (err) throw err;
    var dbo = db.db("mydb");
    dbo.collection("notes").deleteOne({date:req.body.date,time:req.body.time}), (function (err, n) {
        if (err) throw err;
        console.log(n);
        db.close();
      });

  });
})

//edit notes
app.post('/edit', urlencodedParser, function (req, res) {
  const now = new Date();
  const year = now.getFullYear();
  const month = ("0" + (now.getMonth() + 1)).slice(-2);
  const day = ("0" + now.getDate()).slice(-2);
  
  const hour = ("0" + now.getHours()).slice(-2);
  const minute = ("0" + now.getMinutes()).slice(-2);
  const second = ("0" + now.getSeconds()).slice(-2);
  
  // YYYY-MM-DD hh:mm:ss
  const date = `${year}-${month}-${day}`
  const time=  `${hour}:${minute}:${second}`
  MongoClient.connect(url, function (err, db) {
    if (err) throw err;
    var dbo = db.db("mydb");
    var myobj = {
      date:date,
      title:req.body.title,
      content:req.body.content,
      time:time
     
       };
    dbo.collection("notes").update({date:req.body.date,time:req.body.time },
      {
        $set:  {'date': date,
                'title': req.body.title,
                'content':req.body.content,
                'time':time,
      }
            
           
      }), (function (err, n) {
        if (err) throw err;
        console.log(n);
        db.close();
      });

  });
})

   app.listen(8081)
var server = app.listen(8080, function () {  
  
  var host = server.address().address  
  var port = server.address().port  
  console.log("Example app listening at http://%s:%s", host, port)  
  
})