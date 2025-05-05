import 'package:flutter/material.dart';
import '../components/navbar.dart';
import '../components/appBar.dart';
import '../payment/checkout.dart';
import 'package:intl/intl.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const Shoping(),
    );
  }
}

class Item {
  final String name;
  final String type;
  final double price;
  int quantity;
  final String imageUrl;

  Item({
    required this.name,
    required this.type,
    required this.price,
    required this.quantity,
    required this.imageUrl,
  });
}

class Shoping extends StatefulWidget {
  const Shoping({super.key});

  @override
  State<Shoping> createState() => _ShopingState();
}

class _ShopingState extends State<Shoping> {
  List<Item> items = [
    Item(
      name: 'Tenda Dome',
      type: 'TENDA',
      price: 72000,
      quantity: 3,
      imageUrl: 'images/assets_ItemDetails/tenda_bg1.png',
    ),
    Item(
      name: 'Tenda Dome',
      type: 'TENDA',
      price: 60000,
      quantity: 1,
      imageUrl: 'images/assets_ItemDetails/tenda_bg2.png',
    ),
    Item(
      name: 'Tenda Dome',
      type: 'TENDA',
      price: 110000,
      quantity: 2,
      imageUrl: 'images/assets_ItemDetails/tenda_bg3.png',
    ),
    Item(
      name: 'Tenda Dome',
      type: 'TENDA',
      price: 200000,
      quantity: 1,
      imageUrl: 'images/assets_ItemDetails/tenda_bg4.png',
    ),
  ];

  // Track which item is currently expanded
  int? expandedItemIndex;

  // Calculate total price for all items
  double get totalPrice {
    return items.fold(0, (sum, item) => sum + (item.price * item.quantity));
  }

  // Format price to Rupiah
  String formatToRupiah(double price) {
    return 'Rp${price.toStringAsFixed(2).replaceAll('.', ',').replaceAll(RegExp(r'\B(?=(\d{3})+(?!\d))'), '.')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        context: context,
        currentIndex: 2,
      ),
      body: Column(
        children: [
          const Divider(height: 1),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                final itemKey = Key(item.name + index.toString());
                
                return SlidableDeleteItem(
                  key: itemKey,
                  item: item,
                  isExpanded: expandedItemIndex == index,
                  onExpand: () {
                    setState(() {
                      // If already expanded, close it
                      if (expandedItemIndex == index) {
                        expandedItemIndex = null;
                      } else {
                        // Close any other expanded item and open this one
                        expandedItemIndex = index;
                      }
                    });
                  },
                  onDelete: () {
                    setState(() {
                      items.removeAt(index);
                      expandedItemIndex = null;
                    });
                  },
                  formatToRupiah: formatToRupiah,
                );
              },
            ),
          ),
          
          // Modified Place Order Button with more rounded corners and centered text
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    DateTime? startDate;
                    DateTime? endDate;
                    bool isExpanded = false; // untuk kontrol lihat selengkapnya

                    return StatefulBuilder(
                      builder: (context, setState) {
                        // Daftar tanggal yang sudah di-booking (tidak tersedia)
                        final List<DateTime> bookedDates = [
                          DateTime(2025, 5, 5),
                          DateTime(2025, 5, 6),
                          DateTime(2025, 5, 7),
                          DateTime(2025, 5, 15),
                          DateTime(2025, 5, 16),
                          DateTime(2025, 5, 17),
                          DateTime(2025, 5, 18),
                          DateTime(2025, 5, 25),
                          DateTime(2025, 5, 26),
                        ];
                        
                        // Fungsi untuk memeriksa apakah tanggal tersedia
                        bool isDateAvailable(DateTime date) {
                          return !bookedDates.any((bookedDate) => 
                            date.year == bookedDate.year && 
                            date.month == bookedDate.month && 
                            date.day == bookedDate.day
                          );
                        }

                        // Fungsi untuk menghitung durasi sewa
                        int calculateDuration() {
                          if (startDate == null || endDate == null) return 0;
                          return endDate!.difference(startDate!).inDays + 1;
                        }

                        // Fungsi untuk memformat mata uang
                        String formatCurrency(int amount) {
                          return 'Rp${amount.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';
                        }

                        // Data item yang dipesan
                        final List<Map<String, dynamic>> items = [
                          {'name': 'Tenda Dome', 'qty': 2, 'price': 50000, 'days': calculateDuration()},
                          {'name': 'Tenda Besar', 'qty': 1, 'price': 80000, 'days': calculateDuration()},
                          {'name': 'Sleeping Bag', 'qty': 3, 'price': 20000, 'days': calculateDuration()},
                          {'name': 'Matras', 'qty': 2, 'price': 15000, 'days': calculateDuration()},
                          {'name': 'Kompor Camping', 'qty': 1, 'price': 30000, 'days': calculateDuration()},
                        ];

                        // Menghitung total harga
                        int calculateTotal() {
                          int total = 0;
                          for (var item in items) {
                            int qty = item['qty'] as int;
                            int price = item['price'] as int;
                            int days = item['days'] as int;
                            total += qty * price * days;
                          }
                          return total;
                        }

                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          title: Center(
                            child: Text(
                              'Konfirmasi Pesanan',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.green[800],
                              ),
                            ),
                          ),
                          content: SizedBox(
                            width: double.maxFinite,
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // Bagian Detail Pesanan
                                  Container(
                                    padding: EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[100],
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Icons.shopping_cart, color: Colors.green[700], size: 18),
                                            SizedBox(width: 8),
                                            Text(
                                              'Detail Pesanan',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Divider(thickness: 1),
                                        
                                        // List item yang dipesan
                                        Container(
                                          constraints: BoxConstraints(
                                            maxHeight: isExpanded ? double.infinity : 150,
                                          ),
                                          child: SingleChildScrollView(
                                            child: Column(
                                              children: items.map((item) {
                                                int totalPrice = item['qty'] * item['price'] * item['days'];
                                                return Padding(
                                                  padding: EdgeInsets.symmetric(vertical: 6),
                                                  child: Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Expanded(
                                                        flex: 5,
                                                        child: Text(
                                                          '${item['name']} (x${item['qty']})',
                                                          style: TextStyle(fontWeight: FontWeight.w500),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 3,
                                                        child: Text(
                                                          formatCurrency(totalPrice),
                                                          textAlign: TextAlign.right,
                                                          style: TextStyle(fontWeight: FontWeight.w500),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        ),
                                        
                                        // Tombol Lihat Selengkapnya
                                        if (items.length > 3)
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: TextButton(
                                              onPressed: () {
                                                setState(() {
                                                  isExpanded = !isExpanded;
                                                });
                                              },
                                              style: TextButton.styleFrom(
                                                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                                                minimumSize: Size(0, 30),
                                              ),
                                              child: Text(
                                                isExpanded ? 'Tutup' : 'Lihat Semua',
                                                style: TextStyle(
                                                  color: Colors.green[700],
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ),
                                          ),
                                        
                                        Divider(thickness: 1),
                                        // Total Bayar
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Total Bayar',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                            Text(
                                              formatCurrency(calculateTotal()),
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color: Colors.green[700],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  
                                  SizedBox(height: 16),
                                  
                                  // Bagian Tanggal Sewa
                                  Container(
                                    padding: EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[100],
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Icons.calendar_today, color: Colors.green[700], size: 18),
                                            SizedBox(width: 8),
                                            Text(
                                              'Periode Sewa',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Divider(thickness: 1),
                                        SizedBox(height: 8),
                                        
                                        // Tanggal Peminjaman
                                        Text(
                                          'Tanggal Peminjaman',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        GestureDetector(
                                          onTap: () async {
                                            DateTime? picked = await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime.now(),
                                              lastDate: DateTime(2026),
                                              selectableDayPredicate: (DateTime date) {
                                                return isDateAvailable(date);
                                              },
                                              builder: (context, child) {
                                                return Theme(
                                                  data: Theme.of(context).copyWith(
                                                    colorScheme: ColorScheme.light(
                                                      primary: Colors.green[700]!,
                                                      onPrimary: Colors.white,
                                                    ),
                                                  ),
                                                  child: child!,
                                                );
                                              },
                                            );
                                            if (picked != null) {
                                              setState(() {
                                                startDate = picked;
                                                // Reset tanggal akhir jika tanggal awal diubah
                                                if (endDate != null && endDate!.isBefore(startDate!)) {
                                                  endDate = null;
                                                }
                                              });
                                            }
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                            decoration: BoxDecoration(
                                              border: Border.all(color: Colors.grey[400]!),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  startDate == null
                                                      ? 'Pilih tanggal'
                                                      : '${startDate!.day.toString().padLeft(2, '0')}/${startDate!.month.toString().padLeft(2, '0')}/${startDate!.year}',
                                                  style: TextStyle(
                                                    color: startDate == null ? Colors.grey[600] : Colors.black,
                                                  ),
                                                ),
                                                Icon(Icons.calendar_month, color: Colors.grey[600]),
                                              ],
                                            ),
                                          ),
                                        ),
                                        
                                        SizedBox(height: 12),
                                        
                                        // Tanggal Pengembalian
                                        Text(
                                          'Tanggal Pengembalian',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        GestureDetector(
                                          onTap: () async {
                                            if (startDate == null) {
                                              // Tampilkan pesan untuk memilih tanggal awal terlebih dahulu
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(
                                                  content: Text('Pilih tanggal peminjaman terlebih dahulu'),
                                                  backgroundColor: Colors.red[400],
                                                ),
                                              );
                                              return;
                                            }
                                            
                                            DateTime? picked = await showDatePicker(
                                              context: context,
                                              initialDate: startDate!.add(Duration(days: 1)),
                                              firstDate: startDate!,
                                              lastDate: DateTime(2026),
                                              selectableDayPredicate: (DateTime date) {
                                                return isDateAvailable(date);
                                              },
                                              builder: (context, child) {
                                                return Theme(
                                                  data: Theme.of(context).copyWith(
                                                    colorScheme: ColorScheme.light(
                                                      primary: Colors.green[700]!,
                                                      onPrimary: Colors.white,
                                                    ),
                                                  ),
                                                  child: child!,
                                                );
                                              },
                                            );
                                            if (picked != null) {
                                              setState(() {
                                                endDate = picked;
                                              });
                                            }
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                            decoration: BoxDecoration(
                                              border: Border.all(color: Colors.grey[400]!),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  endDate == null
                                                      ? 'Pilih tanggal'
                                                      : '${endDate!.day.toString().padLeft(2, '0')}/${endDate!.month.toString().padLeft(2, '0')}/${endDate!.year}',
                                                  style: TextStyle(
                                                    color: endDate == null ? Colors.grey[600] : Colors.black,
                                                  ),
                                                ),
                                                Icon(Icons.calendar_month, color: Colors.grey[600]),
                                              ],
                                            ),
                                          ),
                                        ),
                                        
                                        SizedBox(height: 12),
                                        
                                        // Durasi Sewa
                                        if (startDate != null && endDate != null)
                                          Container(
                                            padding: EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: Colors.green[50],
                                              borderRadius: BorderRadius.circular(8),
                                              border: Border.all(color: Colors.green[100]!),
                                            ),
                                            child: Row(
                                              children: [
                                                Icon(Icons.info_outline, color: Colors.green[700], size: 16),
                                                SizedBox(width: 8),
                                                Text(
                                                  'Durasi sewa: ${calculateDuration()} hari',
                                                  style: TextStyle(
                                                    color: Colors.green[700],
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          actions: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.grey[300],
                                        foregroundColor: Colors.black,
                                        elevation: 0,
                                        padding: EdgeInsets.symmetric(vertical: 12),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                      ),
                                      child: Text(
                                        'KEMBALI',
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (startDate == null || endDate == null) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text('Pilih tanggal peminjaman dan pengembalian terlebih dahulu'),
                                              backgroundColor: Colors.red[400],
                                            ),
                                          );
                                          return;
                                        }
                                        
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Checkout(),
                                          ),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green[700],
                                        foregroundColor: Colors.white,
                                        elevation: 0,
                                        padding: EdgeInsets.symmetric(vertical: 12),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                      ),
                                      child: Text(
                                        'BAYAR SEKARANG',
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF5D6D3E), // Green color like in image
                foregroundColor: Colors.white,
                elevation: 0,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30), // More rounded corners like in the image
                ),
                minimumSize: Size(double.infinity, 56), // Full width and tall
              ),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24), // Add horizontal padding to center text better
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Total: ${formatToRupiah(totalPrice)}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          'Place Order',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 8),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: buildBottomNavBar(
        context,
        currentIndex: 2,
      ),
    );
  }
}

// Custom slidable item with proper half-open functionality
class SlidableDeleteItem extends StatefulWidget {
  final Item item;
  final bool isExpanded;
  final VoidCallback onExpand;
  final VoidCallback onDelete;
  final String Function(double) formatToRupiah;

  const SlidableDeleteItem({
    super.key,
    required this.item,
    required this.isExpanded,
    required this.onExpand,
    required this.onDelete,
    required this.formatToRupiah,
  });

  @override
  State<SlidableDeleteItem> createState() => _SlidableDeleteItemState();
}

class _SlidableDeleteItemState extends State<SlidableDeleteItem> {
  // For tracking manual drag
  double _dragDistance = 0;
  final double _dragThreshold = 120; // Distance to consider a successful drag
  bool _isDraggingLeft = false; // Track drag direction

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: (details) {
        // Determine initial drag direction
        _isDraggingLeft = true; // Default to left dragging
      },
      onHorizontalDragUpdate: (details) {
        setState(() {
          if (widget.isExpanded) {
            // If already expanded, only allow right swipes (positive delta) to close
            if (details.delta.dx > 0) {
              _dragDistance += details.delta.dx;
              _isDraggingLeft = false;
            }
          } else {
            // If not expanded, only allow left swipes (negative delta) to open
            if (details.delta.dx < 0) {
              _dragDistance += details.delta.dx.abs();
              _isDraggingLeft = true;
            }
          }
        });
      },
      onHorizontalDragEnd: (details) {
        // If dragged far enough, expand or collapse the item
        if (_dragDistance > _dragThreshold) {
          if (_isDraggingLeft) {
            // Left drag - open delete button
            if (!widget.isExpanded) {
              widget.onExpand();
            }
          } else {
            // Right drag - close delete button
            if (widget.isExpanded) {
              widget.onExpand(); // This will toggle it off
            }
          }
        }
        
        // Reset drag distance
        setState(() {
          _dragDistance = 0;
        });
      },
      child: Stack(
        children: [
          // Delete button background (visible when expanded)
          Positioned(
            top: 0,
            right: 0,
            bottom: 0,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: widget.isExpanded ? 80 : 0,
              color: const Color(0xFF5D6D3E),
              child: widget.isExpanded
                  ? InkWell(
                      onTap: widget.onDelete,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.delete_outline,
                              color: Colors.white,
                              size: 28,
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Delete',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : null,
            ),
          ),
          // Item content that slides
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            transform: Matrix4.translationValues(
              widget.isExpanded ? -100 : 0,
              0, 
              0
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey.shade200,
                    width: 1,
                  ),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center, // Center align all row content
                    children: [
                      // Image with price badge
                      Stack(
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                image: AssetImage(widget.item.imageUrl),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 3),
                              decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(12),
                                  bottomRight: Radius.circular(12),
                                ),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 4),
                                  child: Text(
                                    widget.formatToRupiah(widget.item.price),
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11,
                                    ),
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 16),
                      // Middle section with item details and price
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.item.type,
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              widget.item.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),
                            // Price information
                            Text(
                              widget.formatToRupiah(widget.item.price * widget.item.quantity),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // QTY selector - repositioned to align vertically centered
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center, // Center vertically
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'QTY',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    if (widget.item.quantity > 1) {
                                      setState(() {
                                        widget.item.quantity--;
                                      });
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(6),
                                    child: const Icon(
                                      Icons.remove,
                                      size: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 24,
                                  alignment: Alignment.center,
                                  child: Text(
                                    '${widget.item.quantity}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      widget.item.quantity++;
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(6),
                                    child: const Icon(
                                      Icons.add,
                                      size: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Function to build AppBar
PreferredSizeWidget buildAppBar({
  required BuildContext context,
  required int currentIndex,
}) {
  String title = '';
  List<Widget> actions = [];

  // Tentukan judul dan aksi berdasarkan currentIndex
  switch (currentIndex) {
    case 0:
      title = 'Home';
      actions = [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.search, color: Colors.black),
        ),
      ];
      break;
    case 1:
      title = 'Category';
      actions = [
        TextButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Order placed!')),
            );
          },
          style: TextButton.styleFrom(
            foregroundColor: Colors.amber,
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          child: const Text('Place Order'),
        ),
      ];
      break;
    case 2:
      title = 'Shopping Cart';
      // Removed the "Place Order" action from here
      break;
    case 3:
      title = 'Favorite';
      actions = [
        TextButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Order placed!')),
            );
          },
          style: TextButton.styleFrom(
            foregroundColor: Colors.amber,
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          child: const Text('Place Order'),
        ),
      ];
      break;
    case 4:
      title = 'Profile';
      actions = [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.settings, color: Colors.black),
        ),
      ];
      break;
    default:
      title = 'App';
  }

  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    title: Text(
      title,
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    ),
    actions: actions,
  );
}