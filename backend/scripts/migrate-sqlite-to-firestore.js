const path = require('path');
const sqlite3 = require('sqlite3').verbose();
const db = require('../config/db');

const sqlitePath = path.join(__dirname, '..', 'finance_tracker.db');
const sqlite = new sqlite3.Database(sqlitePath);
const transactionsRef = db.collection('transactions');

sqlite.all('SELECT * FROM transactions', async (err, rows) => {
  if (err) {
    console.error('Gagal membaca SQLite:', err.message);
    sqlite.close();
    process.exit(1);
  }

  try {
    if (rows.length === 0) {
      console.log('Tidak ada transaksi lama untuk dimigrasikan.');
      return;
    }

    const batch = db.batch();

    rows.forEach((row) => {
      const { id, title, amount, type, category, note, date } = row;
      batch.set(transactionsRef.doc(id), {
        title,
        amount,
        type,
        category,
        note: note || '',
        date,
      });
    });

    await batch.commit();
    console.log(`${rows.length} transaksi berhasil dimigrasikan ke Firestore.`);
  } catch (error) {
    console.error('Gagal migrasi ke Firestore:', error.message);
    process.exitCode = 1;
  } finally {
    sqlite.close();
  }
});
