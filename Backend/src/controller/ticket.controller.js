import pg from '../db/pg.js';

export const getTickets = async (req, res) => {
    try {
        const id = req.params.id;
        const response = await pg.query('SELECT * FROM ticket WHERE user_story_id = $1', [id]);
        res.status(200).json(response.rows);
    } catch (error) {
        res.status(500).json({message: 'Internal server error'});
    }
}

export const createTicket = async (req, res) => {
    try {
        const {name, description, user_story_id} = req.body;
        const response = await pg.query('INSERT INTO ticket (name, description, user_story_id, state_id) VALUES ($1, $2, $3, $4) RETURNING *', [name, description, user_story_id, 1]);

        res.status(201).json(response.rows[0]);
    } catch (error) {
        res.status(500).json({message: 'Internal server error'});
    }
}

export const createComment = async (req, res) => {
    try {
        const {description, ticket_id} = req.body;
        const user_id = req.user.id;
        const response = await pg.query('INSERT INTO comment (description, ticket_id, user_id) VALUES ($1, $2, $3) RETURNING *', [description, ticket_id, user_id]);

        res.status(201).json(response.rows[0]);
    } catch (error) {
        res.status(500).json({message: 'Internal server error'});
    }
}

export const getComments = async (req, res) => {
    try {
        const id = req.params.id;
        const response = await pg.query('SELECT * FROM comment WHERE ticket_id = $1', [id]);
        res.status(200).json(response.rows);
    } catch (error) {
        res.status(500).json({message: 'Internal server error'});
    }
}

export const updateTicket = async (req, res) => {
    try {
        const id = req.params.id;
        const {name, description, state_id} = req.body;
        const response = await pg.query('UPDATE ticket SET name = $1, description = $2, state_id = $3 WHERE id = $4 RETURNING *', [name, description, state_id, id]);

        res.status(200).json(response.rows[0]);
    } catch (error) {
        res.status(500).json({message: 'Internal server error'});
    }
}

export const updateTicketState = async (req, res) => {
    try {
        const id = req.params.id;
        const {state_id} = req.body;
        const response = await pg.query('UPDATE ticket SET state_id = $1 WHERE id = $2 RETURNING *', [state_id, id]);

        res.status(200).json(response.rows[0]);
    } catch (error) {
        res.status(500).json({message: 'Internal server error'});
    }
}

export const deleteTicket = async (req, res) => {
    try {
        const id = req.params.id;
        await pg.query('DELETE FROM ticket WHERE id = $1', [id]);

        res.status(200).json({message: 'Ticket deleted'});
    } catch (error) {
        res.status(500).json({message: 'Internal server error'});
    }
}