const functions = require('firebase-functions');
const firebase = require('firebase-admin');
const express = require('express');
const engines = require('consolidate');
const app = express();
const firebaseApp = firebase.initializeApp(
    functions.config().firebase
);
app.engine('hbs',engines.handlebars);
app.set('views','./views');
app.set('view engine','hbs');
app.use(express.urlencoded());
app.use(express.json());


//Subscribed Route
app.get('/subscribed', (req, res, next) => {
    res.redirect('../');
})

app.post('/subscribed', (req, res, next) => {
    const emailid = req.body.email;
    const data = {
        email: emailid
    };
    firebaseApp.firestore().collection("subscribers").doc(emailid)
    .set(data)
    .then(ref => {
        res.status(200).render('subscribed');
    })
    .catch(error=> {
        res.status(500).render('error');
    });
});


//Default Route
app.get('/', (req, res, next) => {
    res.render('index');
});

//Export app
exports.app = functions.https.onRequest(app);
