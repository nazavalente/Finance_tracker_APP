import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_constants.dart';
import '../../core/utils/validators.dart';
import '../../models/transaction_model.dart';
import '../../providers/transaction_provider.dart';
import '../../shared/layouts/base_scaffold.dart';
import '../../shared/widgets/custom_button.dart';
import '../../shared/widgets/custom_text_field.dart';
import 'widgets/amount_input.dart';
import 'widgets/category_dropdown.dart';
import 'widgets/date_picker_field.dart';
import 'widgets/type_selector.dart';

class TransactionFormPage extends StatefulWidget {
  final TransactionModel? transaction;

  const TransactionFormPage({super.key, this.transaction});

  @override
  State<TransactionFormPage> createState() => _TransactionFormPageState();
}

class _TransactionFormPageState extends State<TransactionFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();

  String _type = 'expense';
  String _category = AppConstants.categories.first;
  DateTime _selectedDate = DateTime.now();

  bool get isEditMode => widget.transaction != null;
  TransactionModel? get currentTransaction => widget.transaction;

  @override
  void initState() {
    super.initState();
    final transaction = currentTransaction;
    if (transaction != null) {
      _titleController.text = transaction.title;
      _amountController.text = transaction.amount.toStringAsFixed(0);
      _noteController.text = transaction.note;
      _type = transaction.type;
      _category = transaction.category;
      _selectedDate = transaction.date;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() => _selectedDate = pickedDate);
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final provider = context.read<TransactionProvider>();
    final transaction = TransactionModel(
      id:
          currentTransaction?.id ??
          DateTime.now().millisecondsSinceEpoch.toString(),
      title: _titleController.text.trim(),
      amount: double.parse(_amountController.text.trim()),
      type: _type,
      category: _category,
      note: _noteController.text.trim(),
      date: _selectedDate,
    );

    final success = isEditMode
        ? await provider.updateTransaction(transaction)
        : await provider.addTransaction(transaction);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          success
              ? (isEditMode
                    ? 'Transaksi berhasil diupdate'
                    : 'Transaksi berhasil ditambahkan')
              : provider.errorMessage ?? 'Terjadi kesalahan',
        ),
      ),
    );

    if (success) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TransactionProvider>();

    return BaseScaffold(
      title: isEditMode ? 'Edit Transaksi' : 'Tambah Transaksi',
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Tipe Transaksi',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              TypeSelector(
                value: _type,
                onChanged: (value) => setState(() => _type = value),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _titleController,
                label: 'Judul',
                hintText: 'Contoh: Makan siang',
                validator: (value) => Validators.requiredField(value, 'Judul'),
                prefixIcon: const Icon(Icons.title_outlined),
              ),
              const SizedBox(height: 16),
              AmountInput(controller: _amountController),
              const SizedBox(height: 16),
              CategoryDropdown(
                value: _category,
                items: AppConstants.categories,
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _category = value);
                  }
                },
              ),
              const SizedBox(height: 16),
              DatePickerField(selectedDate: _selectedDate, onTap: _pickDate),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _noteController,
                label: 'Catatan',
                hintText: 'Opsional',
                maxLines: 3,
                prefixIcon: const Icon(Icons.notes_outlined),
              ),
              const SizedBox(height: 24),
              CustomButton(
                label: isEditMode ? 'Update' : 'Simpan',
                icon: isEditMode
                    ? Icons.save_outlined
                    : Icons.add_circle_outline,
                isLoading: provider.isLoading,
                onPressed: _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
