import express from 'express';
import morgan from 'morgan';
import cors from 'cors';
import auth from './router/auth.routes.js';
import company from './router/company.routes.js';
import project from './router/project.routes.js';
import userStory from './router/user_story.routes.js';
import ticket from './router/ticket.routes.js';

const app = express();

app.use(express.json());
app.use(morgan('dev'));
app.use(cors('*'));

app.use('/api',auth);
app.use('/api',company);
app.use('/api',project);
app.use('/api',userStory);
app.use('/api',ticket);

app.disable('x-powered-by');

export default app;