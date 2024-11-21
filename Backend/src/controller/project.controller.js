import pg from '../db/pg.js';

export const getProjects = async (req, res) => {
    try {
        const id = req.user.company_id;
        const {rows} = await pg.query('SELECT * FROM project WHERE company_id = $1;', [id]);
        return res.status(200).json(rows);
    } catch (error) {
        return res.status(500).json({message: 'Error on server', error});
    }
}

export const getProject = async (req, res) => {
    try {
        const id = req.params.id;
        const {rows, rowCount} = await pg.query('SELECT p.id ,p.name, p.description, c.name as company FROM project p JOIN company c ON c.id = p.company_id WHERE p.id = $1;', [id]);
        if (rowCount === 0) {
            return res.status(404).json({message: 'project not found'});
        }
        return res.status(200).json(rows[0]);
    } catch (error) {
        return res.status(500).json({message: 'Error on server', error});
    }
}

export const createProject = async (req, res) => {
    try {
        const {name, description} = req.body;
        const company_id = req.user.company_id;
        const {rows} = await pg.query('INSERT INTO project (name, description, company_id) VALUES ($1, $2, $3) RETURNING *;', [name, description, company_id]);

        return res.status(201).json(rows[0]);
    }
    catch (error) {
        return res.status(500).json({message: 'Error on server', error});
    }
}

export const updateProject = async (req, res) => {
    try {
        const id = req.params.id;
        const {name, description} = req.body;
        const {rowCount} = await pg.query('UPDATE project SET name = $1, description = $2 WHERE id = $3;', [name, description, id]);
        if (rowCount === 0) {
            return res.status(404).json({message: 'project not found'});
        }
        return res.status(200).json({message: 'project updated'});
    } catch (error) {
        return res.status(500).json({message: 'Error on server', error});
    }
}

export const deleteProject = async (req, res) => {
    try {
        const id = req.params.id;
        const {rowCount} = await pg.query('DELETE FROM project WHERE id = $1;', [id]);
        if (rowCount === 0) {
            return res.status(404).json({message: 'project not found'});
        }
        return res.status(200).json({message: 'project deleted'});
    } catch (error) {
        return res.status(500).json({message: 'Error on server', error});
    }
}