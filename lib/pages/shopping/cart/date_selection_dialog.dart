import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../../providers/checkout_provider.dart';
import '../../../providers/cart_provider.dart';
import '../../../providers/auth_provider.dart';
import '../payment_data/checkout.dart';

class DateSelectionDialog extends StatefulWidget {
  const DateSelectionDialog({super.key});

  @override
  State<DateSelectionDialog> createState() => DateSelectionDialogState();
}

class DateSelectionDialogState extends State<DateSelectionDialog> {
  DateTime? _pickupDate;
  DateTime? _returnDate;
  int _rentalDays = 1;
  int _totalPrice = 0;

  final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');

  @override
  void initState() {
    super.initState();
    _calculatePrice();
  }

  void _calculatePrice() {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    if (_pickupDate != null && _returnDate != null) {
      _rentalDays = _returnDate!.difference(_pickupDate!).inDays;
      if (_rentalDays <= 0) _rentalDays = 1;
    }
    _totalPrice = cartProvider.totalPrice * _rentalDays;
  }

  Future<void> _selectPickupDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now().add(const Duration(days: 1)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (picked != null) {
      setState(() {
        _pickupDate = picked;
        // If return date is before pickup date, reset it
        if (_returnDate != null && _returnDate!.isBefore(_pickupDate!)) {
          _returnDate = null;
        }
        _calculatePrice();
      });
    }
  }

  Future<void> _selectReturnDate() async {
    if (_pickupDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select pickup date first'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _pickupDate!.add(const Duration(days: 1)),
      firstDate: _pickupDate!.add(const Duration(days: 1)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (picked != null) {
      setState(() {
        _returnDate = picked;
        _calculatePrice();
      });
    }
  }

  void _proceedToCheckout() async {
    if (_pickupDate == null || _returnDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select both pickup and return dates'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final checkoutProvider =
        Provider.of<CheckoutProvider>(context, listen: false);

    if (!authProvider.isAuthenticated || authProvider.user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please login first'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Create transaction
    final success = await checkoutProvider.createTransaction(
      userId: authProvider.user!.userId,
      cabangPengambilanId: 1, // Default branch, you can make this selectable
      tanggalPengambilan: _dateFormat.format(_pickupDate!),
      tanggalPengembalian: _dateFormat.format(_returnDate!),
    );

    if (success && checkoutProvider.transactionId != null) {
      // Close the dialog
      Navigator.of(context)
          .pop(); // Store transaction data in provider for use in checkout2
      checkoutProvider.setTransactionData(
        transactionId: checkoutProvider.transactionId!,
        totalAmount: _totalPrice,
        pickupDate: _dateFormat.format(_pickupDate!),
        returnDate: _dateFormat.format(_returnDate!),
        rentalDays: _rentalDays,
      );

      // Navigate to your existing checkout flow
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Checkout(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text(checkoutProvider.error ?? 'Failed to create transaction'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  String _formatToRupiah(int price) {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    );
    return formatter.format(price);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Pilih Tanggal Sewa',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Pickup Date
            InkWell(
              onTap: _selectPickupDate,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today, color: Color(0xFF5D6D3E)),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Tanggal Pengambilan',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          _pickupDate == null
                              ? 'Pilih tanggal pengambilan'
                              : DateFormat('dd MMM yyyy').format(_pickupDate!),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Return Date
            InkWell(
              onTap: _selectReturnDate,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today, color: Color(0xFF5D6D3E)),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Tanggal Pengembalian',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          _returnDate == null
                              ? 'Pilih tanggal pengembalian'
                              : DateFormat('dd MMM yyyy').format(_returnDate!),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            if (_pickupDate != null && _returnDate != null) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Durasi Sewa:'),
                        Text(
                          '$_rentalDays Hari',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Jumlah Total:'),
                        Text(
                          _formatToRupiah(_totalPrice),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Color(0xFF5D6D3E),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 20),
            Consumer<CheckoutProvider>(
              builder: (context, checkoutProvider, child) {
                return ElevatedButton(
                  onPressed:
                      checkoutProvider.isLoading ? null : _proceedToCheckout,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5D6D3E),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: checkoutProvider.isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : const Text(
                          'Lanjut ke Pembayaran',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
