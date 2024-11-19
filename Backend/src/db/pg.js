import pkg from 'pg';
import {DATABASE_DB, HOST_DB, PORT_DB, USER_DB, PASSWORD_DB} from '../config.js';

const {Pool} = pkg;

const pg = new Pool({
    host: HOST_DB,
    port: PORT_DB,
    user: USER_DB,
    password: PASSWORD_DB,
    database: DATABASE_DB
});

export default pg;