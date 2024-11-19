import { Router } from "express";
import { getCompanies } from "../controller/company.controller.js";

const router = Router();

router.get('/companies', getCompanies);

export default router;