import 'package:flutter/material.dart';
import '../components/navbar.dart';
import '../components/appBar.dart';
import '../payment/checkout.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
  const Shoping({Key? key}) : super(key: key);

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
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          title: Center(
                            child: Text(
                              'Konfirmasi Akhir',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          content: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Bagian Detail Penyewaan
                                Text(
                                  'Detail Penyewaan',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 8),

                                // Scrollable List
                                Container(
                                  constraints: BoxConstraints(
                                    maxHeight: isExpanded ? double.infinity : 150,
                                  ),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Tenda Dome (x2)\nRp50.000 x 2 x 3 Hari = Rp300.000\n'),
                                        Text('Tenda Besar (x1)\nRp80.000 x 1 x 3 Hari = Rp240.000\n'),
                                        Text('Sleeping Bag (x3)\nRp20.000 x 3 x 3 Hari = Rp180.000\n'),
                                        Text('Matras (x2)\nRp15.000 x 2 x 3 Hari = Rp90.000\n'),
                                        Text('Kompor Camping (x1)\nRp30.000 x 1 x 3 Hari = Rp90.000\n'),
                                        Text('Nestle Gas (x1)\nRp20.000 x 1 x 3 Hari = Rp60.000\n'),
                                        Text('Kursi Lipat (x2)\nRp25.000 x 2 x 3 Hari = Rp150.000\n'),
                                        Text('Meja Lipat (x1)\nRp40.000 x 1 x 3 Hari = Rp120.000\n'),
                                        // Tambahin item lain kalau mau
                                      ],
                                    ),
                                  ),
                                ),

                                // Tombol Lihat Selengkapnya
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: () {
                                      setState(() {
                                        isExpanded = !isExpanded;
                                      });
                                    },
                                    child: Text(isExpanded ? 'Tutup' : 'Lihat Selengkapnya'),
                                  ),
                                ),

                                SizedBox(height: 16),

                                // Bagian Durasi Sewa
                                Text(
                                  'Durasi Sewa',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Row(
                                  children: [
                                    // Tanggal Mulai
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () async {
                                          DateTime? picked = await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(2000),
                                            lastDate: DateTime(2100),
                                          );
                                          if (picked != null) {
                                            setState(() {
                                              startDate = picked;
                                            });
                                          }
                                        },
                                        child: AbsorbPointer(
                                          child: TextField(
                                            decoration: InputDecoration(
                                              hintText: startDate == null
                                                  ? 'DD/MM/YYYY'
                                                  : '${startDate!.day.toString().padLeft(2, '0')}/${startDate!.month.toString().padLeft(2, '0')}/${startDate!.year}',
                                              border: OutlineInputBorder(),
                                              contentPadding: EdgeInsets.symmetric(horizontal: 8),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 8),
                                      child: Icon(Icons.arrow_forward),
                                    ),
                                    // Tanggal Selesai
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () async {
                                          DateTime? picked = await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(2000),
                                            lastDate: DateTime(2100),
                                          );
                                          if (picked != null) {
                                            setState(() {
                                              endDate = picked;
                                            });
                                          }
                                        },
                                        child: AbsorbPointer(
                                          child: TextField(
                                            decoration: InputDecoration(
                                              hintText: endDate == null
                                                  ? 'DD/MM/YYYY'
                                                  : '${endDate!.day.toString().padLeft(2, '0')}/${endDate!.month.toString().padLeft(2, '0')}/${endDate!.year}',
                                              border: OutlineInputBorder(),
                                              contentPadding: EdgeInsets.symmetric(horizontal: 8),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16),

                                // Bagian Total Bayar
                                Text(
                                  'Total Bayar',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Rp360.000',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                          actions: [
                            Row(
                              children: [
                                Expanded(
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.grey[300],
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    child: Text(
                                      'KEMBALI',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Expanded(
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Checkout(),
                                        ),
                                      );
                                    },
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.green[700],
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    child: Text(
                                      'BAYAR SEKARANG',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
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
    Key? key,
    required this.item,
    required this.isExpanded,
    required this.onExpand,
    required this.onDelete,
    required this.formatToRupiah,
  }) : super(key: key);

  @override
  State<SlidableDeleteItem> createState() => _SlidableDeleteItemState();
}

class _SlidableDeleteItemState extends State<SlidableDeleteItem> {
  // For tracking manual drag
  double _dragDistance = 0;
  double _dragThreshold = 120; // Distance to consider a successful drag
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
              widget.isExpanded ? -80 : 0, 
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
              child: Row(
                children: [
                  // Image with price badge
                  Stack(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
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
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(12),
                              bottomRight: Radius.circular(12),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              widget.formatToRupiah(widget.item.price),
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  // Item details
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
                        ),
                      ],
                    ),
                  ),
                  // Price
                  Text(
                    widget.formatToRupiah(widget.item.price * widget.item.quantity),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Quantity selector
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
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
                                padding: const EdgeInsets.all(8),
                                child: const Icon(
                                  Icons.remove,
                                  size: 16,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            Container(
                              width: 30,
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
                                padding: const EdgeInsets.all(8),
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