const transactionModel = require('../models/transactionModel');

class TransactionController {
  _isRequiredPayloadComplete({ id, title, amount, type, category, date }) {
    return id && title && amount !== undefined && type && category && date;
  }

  async getTransactions(req, res) {
    try {
      const transactions = await transactionModel.getAllTransactions();
      res.status(200).json(transactions);
    } catch (error) {
      res.status(500).json({
        message: 'Gagal mengambil transaksi',
        error: error.message,
      });
    }
  }

  async createTransaction(req, res) {
    try {
      const { id, title, amount, type, category, note, date } = req.body;

      if (!this._isRequiredPayloadComplete(req.body)) {
        return res.status(400).json({ message: 'Field wajib belum lengkap' });
      }

      const newTransaction = await transactionModel.createTransaction({
        id,
        title,
        amount,
        type,
        category,
        note: note || '',
        date,
      });

      res.status(201).json(newTransaction);
    } catch (error) {
      res.status(500).json({
        message: 'Gagal menambah transaksi',
        error: error.message,
      });
    }
  }

  async updateTransaction(req, res) {
    try {
      const { id } = req.params;
      const { title, amount, type, category, note, date } = req.body;

      const existing = await transactionModel.getTransactionById(id);
      if (!existing) {
        return res.status(404).json({ message: 'Transaksi tidak ditemukan' });
      }

      const changes = await transactionModel.updateTransaction(id, {
        title,
        amount,
        type,
        category,
        note: note || '',
        date,
      });

      if (changes === 0) {
        return res.status(400).json({ message: 'Transaksi gagal diupdate' });
      }

      const updated = await transactionModel.getTransactionById(id);
      res.status(200).json(updated);
    } catch (error) {
      res.status(500).json({
        message: 'Gagal update transaksi',
        error: error.message,
      });
    }
  }

  async deleteTransaction(req, res) {
    try {
      const { id } = req.params;

      const existing = await transactionModel.getTransactionById(id);
      if (!existing) {
        return res.status(404).json({ message: 'Transaksi tidak ditemukan' });
      }

      const changes = await transactionModel.deleteTransaction(id);

      if (changes === 0) {
        return res.status(400).json({ message: 'Transaksi gagal dihapus' });
      }

      res.status(200).json({ message: 'Transaksi berhasil dihapus' });
    } catch (error) {
      res.status(500).json({
        message: 'Gagal hapus transaksi',
        error: error.message,
      });
    }
  }
}

module.exports = new TransactionController();
