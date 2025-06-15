import 'package:flutter/material.dart';
import '../after_sales/thankyouPage.dart'; // pastikan nama file kamu kecil semua

class Checkout2 extends StatefulWidget {
  const Checkout2({super.key});

  @override
  _Checkout2State createState() => _Checkout2State();
}

class _Checkout2State extends State<Checkout2> {
  String selectedPayment = 'QRIS';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Payment Method', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            buildStepIndicator(),
            const SizedBox(height: 24), 
            buildPaymentOptions(),
            const SizedBox(height: 24),
            Expanded(
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    buildPaymentContent(),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            buildConfirmButton(context, _formKey),
          ],
        ),
      ),
    );
  }

  // Step Indicator
  Widget buildStepIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        stepCircle(isActive: false),
        stepLine(),
        stepCircle(isActive: true),
      ],
    );
  }

  Widget stepCircle({required bool isActive}) {
    return Column(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: isActive
                ? null
                : Border.all(color: const Color(0xFF627D2C), width: 2),
            color: isActive ? const Color(0xFF627D2C) : Colors.transparent,
          ),
          child: Center(
            child: Icon(
              Icons.check,
              size: 16,
              color: isActive ? Colors.white : const Color(0xFF627D2C),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          isActive ? 'Payment Method' : 'Rent Confirmation',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget stepLine() {
    return Container(
      width: 40,
      height: 2,
      color: Colors.grey[300],
      margin: const EdgeInsets.symmetric(horizontal: 8),
    );
  }

  // Payment Options
  Widget buildPaymentOptions() {
    return Row(
      children: [
        Expanded(
          child: buildPaymentTab('QRIS'),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: buildPaymentTab('Transfer Bank'),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: buildPaymentTab('Cash'),
        ),
      ],
    );
  }

  Widget buildPaymentTab(String paymentType) {
    bool isSelected = selectedPayment == paymentType;
    
    return OutlinedButton(
      onPressed: () {
        setState(() {
          selectedPayment = paymentType;
        });
      },
      style: OutlinedButton.styleFrom(
        side: BorderSide(
          color: isSelected ? const Color(0xFF627D2C) : Colors.grey,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: isSelected
            ? const Color(0xFF627D2C)
            : Colors.white,
      ),
      child: Text(
        paymentType, 
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
          fontSize: 12,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  // Payment Content based on selected method
  Widget buildPaymentContent() {
    switch (selectedPayment) {
      case 'QRIS':
        return buildQrisPayment();
      case 'Transfer Bank':
        return buildBankTransfer();
      case 'Cash':
        return buildCashPayment();
      default:
        return buildQrisPayment();
    }
  }

  // QRIS Payment
  Widget buildQrisPayment() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 16),
        const Text(
          'Scan QR Code untuk Pembayaran',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 24),
        Center(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                Image.asset(
                  'images/assets_PaymentMethods/contohQRIS.png',
                  width: 380,
                  height: 380,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 12),
                const Text(
                  'QRIS - PlantRent',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 32),
        ElevatedButton.icon(
          onPressed: () {
            // Logic to download receipt
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Bukti transaksi diunduh')),
            );
          },
          icon: const Icon(Icons.download, color: Colors.white),
          label: const Text('Download Bukti Transaksi', style: TextStyle(color: Colors.white)),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF627D2C),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
      ],
    );
  }

  // Bank Transfer
  Widget buildBankTransfer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        const Text(
          'Transfer ke Rekening Berikut:',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 24),
        _buildBankCard(
          bankName: 'Bank BCA',
          accountNumber: '1234 5678 9012 3456',
          accountName: 'PT PlantRent Indonesia',
          bankLogo: 'images/assets_PaymentMethods/logo_bca.png',
        ),
        const SizedBox(height: 16),
        _buildBankCard(
          bankName: 'Bank Mandiri',
          accountNumber: '0987 6543 2109 8765',
          accountName: 'PT PlantRent Indonesia',
          bankLogo: 'images/assets_PaymentMethods/logo_mandiri.png',
        ),
        const SizedBox(height: 24),
        const Text(
          'Catatan:',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          '• Mohon transfer sesuai dengan jumlah yang tertera\n'
          '• Konfirmasi pembayaran akan diproses dalam 1x24 jam\n'
          '• Pastikan menyimpan bukti pembayaran',
          style: TextStyle(fontSize: 14),
        ),
        const SizedBox(height: 32),
        Center(
          child: ElevatedButton.icon(
            onPressed: () {
              // Logic to download receipt
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Bukti transaksi diunduh')),
              );
            },
            icon: const Icon(Icons.download, color: Colors.white),
            label: const Text('Download Bukti Transaksi', style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF627D2C),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBankCard({
    required String bankName,
    required String accountNumber,
    required String accountName,
    required String bankLogo,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFBCCB9F)),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[200],
                ),
                // Replace with actual bank logo
                child: const Icon(Icons.account_balance, color: Color(0xFF627D2C)),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    bankName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Rekening $bankName',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Nomor Rekening:',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                accountNumber,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.copy, size: 20, color: Color(0xFF627D2C)),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Nomor rekening disalin')),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Atas Nama:',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            accountName,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  // Cash Payment
  Widget buildCashPayment() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFFF8F9F4),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFBCCB9F)),
          ),
          child: Column(
            children: [
              const Icon(
                Icons.store,
                size: 60,
                color: Color(0xFF627D2C),
              ),
              const SizedBox(height: 16),
              const Text(
                'Pembayaran di Tempat',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF627D2C),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Anda dapat melakukan pembayaran langsung di booth PlantRent kami yang berlokasi di:',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              const Text(
                'Botanical Garden Mall\nLantai 3, Booth B12\nJl. Taman Bunga No. 123\nJakarta Selatan',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Booth buka setiap hari:\n10:00 - 21:00 WIB',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Harap bawa ID atau konfirmasi pesanan untuk mempermudah proses pembayaran.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Confirm Button
  Widget buildConfirmButton(BuildContext context, GlobalKey<FormState> formKey) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState != null) {
            if (selectedPayment == 'Transfer Bank' || selectedPayment == 'QRIS' || selectedPayment == 'Cash') {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Order Confirmed!')),
              );
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ThankYouPage()),
              );
            }
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF627D2C),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        child: const Text(
          'CONFIRM ORDER',
          style: TextStyle(
            fontSize: 16,
            letterSpacing: 1.5,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}