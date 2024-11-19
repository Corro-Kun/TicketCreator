import pg from '../db/pg.js';
import crypto from 'bcryptjs';
import CreateToken from '../lib/swj.js';

export const login = async (req, res) => {
    try {
        const {email, password} = req.body;

        const {rows, rowCount} = await pg.query('SELECT * FROM user_company WHERE email = $1;', [email]);

        if (rowCount === 0) {
            return res.status(404).json({message: "user no found"});
        }

        const match = await crypto.compare(password, rows[0].password);

        if (!match) {
            return res.status(401).json({message: "Incorrect password"});
        }

        const token = await CreateToken({id: rows[0].id, company_id: rows[0].company_id});

        return res.status(200).json({token: token});
    } catch (error) {
        return res.status(500).json({message: 'Error on server', error});
    }
 
};

export const register = async (req, res) => {
    try {
        const {name, email, password, company_id} = req.body;

        const {rowCount} = await pg.query('SELECT * FROM company WHERE id = $1;', [company_id]);

        if (rowCount === 0) {
            return res.status(404).json({message: 'company not found'});
        }

        const {rowCount: rowCount2} = await pg.query('SELECT * FROM user_company WHERE email = $1;', [email]);

        if (rowCount2 > 0) {
            return res.status(401).json({message: 'email already exists'});
        };

        const hash = await crypto.hash(password, 10);

        const {rows} = await pg.query('INSERT INTO user_company (name ,email, password, company_id) VALUES ($1, $2, $3, $4) RETURNING *;', [name, email, hash, company_id]);

        const token = await CreateToken({id: rows[0].id, company_id: rows[0].company_id});

        return res.status(201).json({token: token});
    } catch (error) {
        return res.status(500).json({message: 'Error on server', error});
    }
}