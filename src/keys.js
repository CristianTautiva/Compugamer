const host = process.env.HOST_DB;
const user = process.env.USER_DB;
const password = process.env.PASS_DB;
const database = process.env.DATABASE;

module.exports = {
   database: {
          host,
          user,
          password,
          database
   }
}