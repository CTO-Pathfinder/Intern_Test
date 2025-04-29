const express = require('express');
const cors = require('cors')
const mysql = require('mysql2/promise')
const dotenv = require('dotenv')
const bodyParser = require('body-parser')

const jsonParser = bodyParser.json()

dotenv.config()

const port = process.env.PORT;

const rtr = express.Router();

const app = express();

app.use('/api', rtr);

app.listen(port, () => {
  console.log(`App listening at http://localhost:${port}`);
});

app.use(cors({
    origin: process.env.NODE_ENV === 'production' ? process.env.HOST : 'http://localhost:3000',
    methods: ["GET", "POST"],
    credentials: true
}))


const hostname = 'localhost';
const username = process.env.NODE_ENV === 'production' ? process.env.DB_USERNAME : 'root';
const password = process.env.NODE_ENV === 'production' ? process.env.DB_PASSWORD : process.env.LOCAL_DB_PASSWORD;
const database = 'accounting';
const dbPort = '3306';
const connectionLimit = 10;
const connectTimeout = 10000;

const pool = mysql.createPool({
  host: hostname,
  user: username,
  password: password,
  database: database,
  port: dbPort,
  connectionLimit: connectionLimit,
  connectTimeout: connectTimeout,
  dateStrings: true
});

rtr.get('/ents', async (req, res) => {
    let con
    try {
        con = await pool.getConnection()
        let sql = `SELECT ID, Name FROM Entities`
        let [ents] = await con.query(sql)
        res.status(200).send(ents)
    } catch (e) {
        console.log(e)
        res.json({msg: e})
    } finally {
        if(con) con.release()
    }
})