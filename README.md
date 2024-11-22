## Ticket Creator

a web application where you can monitor the progress of different development projects


## Tech Stack

[![My framwork](https://skillicons.dev/icons?i=astro,svelte,express,postgres)]()

**Client:** Astro, Svelte

**Server:** Express

**Database:** PostgreSQL

## Run Locally

Node version 18 or higher is required and PostgreSQL is required installed

Clone the project

```bash
  git clone https://github.com/Corro-Kun/TicketCreator.git
```

Go to the project directory

```bash
  cd TicketCreator
```

Install dependencies

```bash
  # linux
  ./server.sh i all
  # windows with git bash or cmd
  .\server.bat i all
  # windows with powershell
  .\server.ps1 i all
```

Create a .env file in the backend folder with the following content

```env
  PORT=3000
  HOST_DB = "localhost"
  PORT_DB = 5432
  USER_DB = "postgres"
  PASSWORD_DB = ""
  DATABASE_DB = "ticketcreator"
  TOKEN_PASSWORD = "1234"
```

and in the frontend folder with the following content

```env
  PUBLIC_API=http://localhost:3000/api
```

Start the app

```bash
  # linux
  ./server.sh run all
  # windows with git bash or cmd
  .\server.bat run all
  # windows with powershell
  .\server.ps1 run all
```

## Screenshots

<img src="https://res.cloudinary.com/daqrkk4sr/image/upload/f_auto,q_auto/zkipbfm4asusoec1ffsy" alt="App Screenshot">
<br>
<br>
<img src="https://res.cloudinary.com/daqrkk4sr/image/upload/f_auto,q_auto/niegcowhhsramppjymup" alt="App Screenshot">
<br>
<br>
<img src="https://res.cloudinary.com/daqrkk4sr/image/upload/f_auto,q_auto/imafj11e7rkug3zcssq4" alt="App Screenshot">

## Color Reference

| Color             | Hex                                                                |
| ----------------- | ------------------------------------------------------------------ |
| Color Background | ![#F5F5F7](https://via.placeholder.com/10/F5F5F7?text=+) #F5F5F7 |
| Color Background Secondary | ![#72BF78](https://via.placeholder.com/10/72BF78?text=+) #72BF78 |
| Color Text | ![#05050a](https://via.placeholder.com/10/05050a?text=+) #05050a |
| Color Text Hover | ![#f7f7f7](https://via.placeholder.com/10/f7f7f7?text=+) #f7f7f7 |
