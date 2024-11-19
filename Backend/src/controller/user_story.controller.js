import pg from '../db/pg.js';

export const getUserStories = async (req, res) => {
    try {
        const id = req.params.id;
        const {rows} = await pg.query('SELECT * FROM user_story WHERE project_id = $1;', [id]);
        return res.status(200).json(rows);
    } catch (error) {
        return res.status(500).json({message: 'Error on server', error});
    }
}

export const getUserStory = async (req, res) => {
    try {
        const id = req.params.id;
        const {rows, rowCount} = await pg.query('SELECT * FROM user_story WHERE id = $1;', [id]);
        if (rowCount === 0) {
            return res.status(404).json({message: 'user_story not found'});
        }
        return res.status(200).json(rows[0]);
    } catch (error) {
        return res.status(500).json({message: 'Error on server', error});
    }
}

export const createUserStory = async (req, res) => {
    try {
        const {name, description, priority_id, project_id, name_ticket, description_ticket} = req.body;
        const {rows} = await pg.query('INSERT INTO user_story (name, description, priority_id, project_id) VALUES ($1, $2, $3, $4) RETURNING *;', [name, description, priority_id, project_id]);
        const id = rows[0].id;
        const {rows: rows_ticket} = await pg.query('INSERT INTO ticket (name, description, state_id, user_story_id) VALUES ($1, $2, $3, $4) RETURNING *;', [name_ticket, description_ticket, 1, id]);

        return res.status(201).json({user_story: rows[0], ticket: rows_ticket[0]});
    }
    catch (error) {
        return res.status(500).json({message: 'Error on server', error});
    }
}

export const updateUserStory = async (req, res) => {
    try {
        const id = req.params.id;
        const {name, description, priority_id} = req.body;
        const {rowCount} = await pg.query('UPDATE user_story SET name = $1, description = $2, priority_id = $3 WHERE id = $4;', [name, description, priority_id, id]);
        if (rowCount === 0) {
            return res.status(404).json({message: 'user_story not found'});
        }
        return res.status(200).json({message: 'user_story updated'});
    } catch (error) {
        return res.status(500).json({message: 'Error on server', error});
    }
}

export const deleteUserStory = async (req, res) => {
    try {
        const id = req.params.id;
        const {rowCount} = await pg.query('DELETE FROM user_story WHERE id = $1;', [id]);
        if (rowCount === 0) {
            return res.status(404).json({message: 'user_story not found'});
        }
        return res.status(200).json({message: 'user_story deleted'});
    } catch (error) {
        return res.status(500).json({message: 'Error on server', error});
    }
}