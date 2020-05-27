const express = require('express');
const router = express.Router();
const passport = require('passport');
const { isLoggedIn, isNotLoggedIn } = require('../lib/protectLinks');
const LocalStorage = require('node-localstorage').LocalStorage,
localStorage = new LocalStorage('./scratch');

router.get('/signup', isNotLoggedIn,(req,res)=>{
      localStorage.clear();
      res.render('auth/signup');
      
});

router.post('/signup', passport.authenticate('local.signup', {
  successRedirect: '/profile',
  failureRedirect: '/signup',
  failureFlash: true
}));

router.get('/signin',isNotLoggedIn,(req,res)=>{
  localStorage.clear();
  res.render('auth/signin');
  
});

router.post('/signin',(req,res,next)=>{
  passport.authenticate('local.signin', {
    successRedirect: '/profile',
    failureRedirect: '/signin',
    failureFlash: true
  })(req,res,next)
  
});



router.get('/profile',isLoggedIn,(req,res)=>{
  res.render('profiles/profile');
});

router.get('/logout',(req,res)=>{
  req.logOut();
  res.redirect('/');
});


module.exports = router;