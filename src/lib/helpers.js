const bcrypt = require('bcryptjs');


const helpers = {};
helpers.encryptPassword = async (password) => {
  const salt = await bcrypt.genSalt(10);
  const finalPass = await bcrypt.hash(password,salt);
  return finalPass;
};

helpers.matchPassword = async (password, savedPassword) =>{
    try {
       return bcrypt.compare(password, savedPassword);
    } catch (error) {
        console.log(e);
    }
};



module.exports = helpers;