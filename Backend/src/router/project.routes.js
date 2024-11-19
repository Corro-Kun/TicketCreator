import { Router } from "express";
import { createProject, deleteProject, getProject, getProjects, updateProject } from "../controller/project.controller.js";
import ValidateToken from "../middlewares/ValidateToken.js";

const router = Router();

router.get('/projects', ValidateToken, getProjects);
router.get('/project/:id', ValidateToken, getProject);
router.post('/project', ValidateToken, createProject);
router.put('/project/:id', ValidateToken, updateProject);
router.delete('/project/:id', ValidateToken, deleteProject);

export default router;