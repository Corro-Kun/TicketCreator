import { Router } from "express";
import ValidateToken from "../middlewares/ValidateToken.js";
import { getTickets, createTicket, createComment, getComments, updateTicket, updateTicketState, deleteTicket } from "../controller/ticket.controller.js";

const router = Router();

router.get('/tickets/:id', ValidateToken, getTickets);
router.post('/ticket', ValidateToken, createTicket);
router.post('/comment', ValidateToken, createComment);
router.get('/comments/:id', ValidateToken, getComments);
router.put('/ticket/:id', ValidateToken, updateTicket);
router.put('/ticket/state/:id', ValidateToken, updateTicketState);
router.delete('/ticket/:id', ValidateToken, deleteTicket);

export default router;