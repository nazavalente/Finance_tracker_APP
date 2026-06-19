const express = require('express');
const router = express.Router();
const transactionController = require('../controllers/transactionController');

router.get('/', transactionController.getTransactions.bind(transactionController));
router.post('/', transactionController.createTransaction.bind(transactionController));
router.put('/:id', transactionController.updateTransaction.bind(transactionController));
router.delete('/:id', transactionController.deleteTransaction.bind(transactionController));

module.exports = router;
