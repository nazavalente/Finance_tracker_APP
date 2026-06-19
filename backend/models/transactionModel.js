const db = require('../config/db');

const mapDocument = (doc) => ({
  id: doc.id,
  ...doc.data(),
});

class TransactionModel {
  constructor(database) {
    this.transactionsRef = database.collection('transactions');
  }

  _toPayload(transaction) {
    const { title, amount, type, category, note, date } = transaction;

    return {
      title,
      amount,
      type,
      category,
      note,
      date,
    };
  }

  async getAllTransactions() {
    const snapshot = await this.transactionsRef.orderBy('date', 'desc').get();
    return snapshot.docs.map(mapDocument);
  }

  async getTransactionById(id) {
    const doc = await this.transactionsRef.doc(id).get();
    return doc.exists ? mapDocument(doc) : null;
  }

  async createTransaction(transaction) {
    const { id } = transaction;
    const payload = this._toPayload(transaction);

    await this.transactionsRef.doc(id).set(payload);

    return {
      id,
      ...payload,
    };
  }

  async updateTransaction(id, transaction) {
    await this.transactionsRef.doc(id).update(this._toPayload(transaction));
    return 1;
  }

  async deleteTransaction(id) {
    await this.transactionsRef.doc(id).delete();
    return 1;
  }
}

module.exports = new TransactionModel(db);
