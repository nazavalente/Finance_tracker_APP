const express = require('express');
const cors = require('cors');
const transactionRoutes = require('./routes/transactionRoutes');
require('./config/db');

const app = express();
const PORT = process.env.PORT || 8000;

app.use(cors());
app.use(express.json());

app.get('/', (req, res) => {
  res.json({ message: 'Finance Tracker API is running' });
});

app.use('/api/transactions', transactionRoutes);

app.listen(PORT, '0.0.0.0', () => {
  console.log(`Server berjalan di http://0.0.0.0:${PORT}`);
});
