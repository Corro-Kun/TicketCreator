import jws from 'jsonwebtoken';
import { TOKEN } from '../config.js';

function CreateToken(payload){
    return new Promise((resolve, reject)=>{
        jws.sign(payload, TOKEN,{ expiresIn: "30d" }, (err, token)=> {
            if(err) reject(err); 
            resolve(token); 
        });
    });
}

export default CreateToken