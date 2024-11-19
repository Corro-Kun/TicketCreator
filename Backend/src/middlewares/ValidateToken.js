import pg from '../db/pg.js';
import swj from "jsonwebtoken";
import {TOKEN} from "../config.js";

const ValidateToken = (req, res, next) => {
    const token = req.headers.token;

    if (!token){
        return res.status(403).json({message: "token is required"});
    }

    swj.verify(token, TOKEN, async (err, decoded) => {
        if (err){
            return res.status(401).json({message: "Invalid token"});
        }

        delete decoded.iat;
        delete decoded.exp;

        const {rows: user} = await pg.query('SELECT * FROM user_company WHERE id = $1;', [decoded.id]);

        if (!user.length){
            return res.status(401).json({message: "user not found"});
        }

        req.user = decoded;

        next();
    });
};

export default ValidateToken;