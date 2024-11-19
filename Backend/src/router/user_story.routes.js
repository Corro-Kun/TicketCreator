import { Router } from "express";
import { getUserStories, getUserStory, createUserStory, deleteUserStory, updateUserStory } from "../controller/user_story.controller.js";
import ValidateToken from "../middlewares/ValidateToken.js";

const router = Router();

router.get('/user_stories/:id', ValidateToken, getUserStories);
router.get('/user_story/:id', ValidateToken, getUserStory);
router.post('/user_story', ValidateToken, createUserStory);
router.put('/user_story/:id', ValidateToken, updateUserStory);
router.delete('/user_story/:id', ValidateToken, deleteUserStory);

export default router;