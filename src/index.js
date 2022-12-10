// const mongoose = require('mongoose');
const customers = require('./routes/customers');
const healthz = require('./routes/healthz');
const express = require('express');
const app = express();


app.use(express.json());
app.use('/api/customers', customers);
app.use('/_healthz', healthz);

const port = process.env.PORT || 3000;
app.listen(port, () => console.log(`Listening on port ${port}...`));