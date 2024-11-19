import pg from '../db/pg.js';

export const getCompanies = async (req, res) => {
    try {
        const {rows} = await pg.query('SELECT * FROM company;');
        return res.status(200).json(rows);
    } catch (error) {
        return res.status(500).json({message: 'Error on server', error});
    }
}