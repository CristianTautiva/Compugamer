const express = require('express');
const morgan = require('morgan');
const exphbs = require('express-handlebars');
const path = require('path');
const flash = require('connect-flash');
const session = require('express-session');
const MySQLStore = require('express-mysql-session');
const passport = require('passport');
const multer = require('multer');
const uuid = require('uuid').v4;
const bodyParser = require('body-parser');
require('dotenv').config();
const pdfRoute = require('./routes/pdfmake');
const { database } = require('./keys');



//inicializaciones
const app = express();
require('./lib/passport');


//settings
app.set('port', process.env.PORT || 4000);
app.set('views', path.join(__dirname, 'views'));
app.engine('.hbs', exphbs({
    defaultLayout: 'main',
    layoutsDir: path.join(app.get('views'),'layouts'),
    partialsDir: path.join(app.get('views'),'partials'),
    extname: '.hbs',
    helpers: require('./lib/handlebars')
}));
app.set('view engine', '.hbs');

//middlewares
app.use(session({
    secret: 'Dcrisnodesession',
    resave: false,
    saveUninitialized: false,
    store: new MySQLStore(database)
}));
app.use(flash());
app.use(morgan('dev'));
app.use(bodyParser.urlencoded({extended: true}));
app.use(express.json());
app.use(passport.initialize());
app.use(passport.session());
const storage = multer.diskStorage({
    destination: path.join(__dirname,'public/uploads'),fileFilter(req, file, next) {
        const isPhoto = file.mimetype.startsWith('image/');
        if (isPhoto) {
          next(null, true);
        } else {
          next({ message: "El tipo de archivo no es válido" }, false);
        }
    },
    filename: (req,file,cb)=>{
        cb(null, uuid() + path.extname(file.originalname));
    }
});
app.use(multer({storage: storage}).single('img'));

//static files
app.use(express.static(path.join(__dirname, 'public')));

//global variables
app.use((req,res,next)=>{
    app.locals.success = req.flash('success');
    app.locals.message = req.flash('message');
    app.locals.user = req.user;
    next();
});



//routes
app.use(require('./routes/'));
app.use(require('./routes/authentication'));
app.use('/links', require('./routes/links'));
app.use(require('./routes/search'));
app.use('/pdfMake', pdfRoute);
app.use(require('./routes/ref'));

//public
app.use(express.static(path.join(__dirname,'public')));

//starting the server

app.listen(app.get('port'), () =>{

    console.log(`Server on port ${app.get('port')}`);
    console.log('Environment:', process.env.NODE_ENV);
});