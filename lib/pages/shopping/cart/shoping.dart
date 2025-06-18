/*
* File : shoping.dart
* Deskripsi : Halaman keranjang belanja yang menampilkan item yang akan dibeli
* Dependencies : 
*   - navbar.dart: untuk komponen navigasi
*   - appBar.dart: untuk komponen app bar
*   - checkout.dart: untuk navigasi ke halaman checkout
*   - intl: untuk format angka ke format Rupiah
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../components/navbar.dart';
import '../../../providers/cart_provider.dart';
import '../../../providers/auth_provider.dart';
import '../../../models/models.dart';
import '../../detail_items/detailItem.dart';
import 'date_selection_dialog.dart';

void main() {
  runApp(const MyApp());
}

/*
* Class : MyApp
* Deskripsi : Widget root aplikasi untuk halaman shopping cart
* Bagian Layar : Root aplikasi
*/
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  /*
  * Method : build
  * Deskripsi : Membangun widget MaterialApp yang berisi Shoping widget
  * Parameter : context - BuildContext untuk akses ke fitur framework
  * Return : Widget MaterialApp yang berisi halaman shopping cart
  */
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

/*
* Class : Shoping
* Deskripsi : Widget halaman keranjang belanja, merupakan StatefulWidget
* Bagian Layar : Halaman keranjang belanja
*/
class Shoping extends StatefulWidget {
  const Shoping({super.key});

  @override
  State<Shoping> createState() => _ShopingState();
}

/*
* Class : _ShopingState
* Deskripsi : State untuk widget Shoping
* Bagian Layar : Mengelola state dan tampilan halaman keranjang belanja
*/
class _ShopingState extends State<Shoping> {
  // Track which item is currently expanded
  int? expandedItemIndex;

  @override
  void initState() {
    super.initState();
    _loadCart();
  }

  /*
  * Method : _loadCart
  * Deskripsi : Memuat data keranjang dari API menggunakan user ID yang sudah login
  * Parameter : -
  * Return : -
  */
  void _loadCart() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    if (authProvider.isAuthenticated && authProvider.user != null) {
      cartProvider.loadCart(authProvider.user!.userId);
    }
  }

  /*
  * Method : formatToRupiah
  * Deskripsi : Memformat angka menjadi format mata uang Rupiah
  * Parameter : price - int nilai harga yang akan diformat
  * Return : String hasil format dalam Rupiah
  */
  String formatToRupiah(int price) {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    );
    return formatter.format(price);
  }

  /*
  * Method : build
  * Deskripsi : Membangun UI untuk halaman keranjang belanja
  * Parameter : context - BuildContext untuk akses ke fitur framework
  * Return : Widget Scaffold berisi daftar item dalam keranjang
  */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        context: context,
        currentIndex: 2,
      ),
      body: Consumer2<CartProvider, AuthProvider>(
        builder: (context, cartProvider, authProvider, child) {
          if (cartProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (cartProvider.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${cartProvider.error}'),
                  ElevatedButton(
                    onPressed: _loadCart,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          final cart = cartProvider.cart;
          if (cart == null || cart.items.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 80,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Your cart is empty',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              const Divider(height: 1),
              Expanded(
                child: ListView.builder(
                  itemCount: cart.items.length,
                  itemBuilder: (context, index) {
                    final item = cart.items[index];
                    final itemKey = Key(item.id.toString());

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
                      onDelete: () async {
                        if (authProvider.isAuthenticated &&
                            authProvider.user != null) {
                          final success = await cartProvider.removeItem(
                            authProvider.user!.userId,
                            item.id,
                          );
                          if (success) {
                            setState(() {
                              expandedItemIndex = null;
                            });
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(cartProvider.error ??
                                    'Failed to remove item'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        }
                      },
                      formatToRupiah: formatToRupiah,
                      onQuantityChanged: (newQuantity) async {
                        if (authProvider.isAuthenticated &&
                            authProvider.user != null) {
                          await cartProvider.updateItemQuantity(
                            authProvider.user!.userId,
                            item.id,
                            newQuantity,
                          );
                        }
                      },
                    );
                  },
                ),
              ),

              // Place Order Button
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: cart.items.isNotEmpty
                      ? () {
                          // Show date selection dialog
                          showDialog(
                            context: context,
                            builder: (context) => const DateSelectionDialog(),
                          );
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5D6D3E),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    minimumSize: const Size(double.infinity, 56),
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'Total: ${formatToRupiah(cartProvider.totalPrice)}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Row(
                          children: [
                            Text(
                              'Place Order',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(Icons.arrow_forward),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
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
  final CartItem item;
  final bool isExpanded;
  final VoidCallback onExpand;
  final VoidCallback onDelete;
  final String Function(int) formatToRupiah;
  final Function(int) onQuantityChanged;

  const SlidableDeleteItem({
    super.key,
    required this.item,
    required this.isExpanded,
    required this.onExpand,
    required this.onDelete,
    required this.formatToRupiah,
    required this.onQuantityChanged,
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
          ), // Item content that slides
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            transform:
                Matrix4.translationValues(widget.isExpanded ? -100 : 0, 0, 0),
            child: InkWell(
              onTap: () {
                // Navigate to detail page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        DetailItem(barangId: widget.item.barangId),
                  ),
                );
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
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
                      crossAxisAlignment: CrossAxisAlignment
                          .center, // Center align all row content
                      children: [
                        // Image with price badge
                        Stack(
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.grey.shade200,
                              ),
                              child: widget.item.foto != null &&
                                      widget.item.foto!.isNotEmpty
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.network(
                                        widget.item.foto!,
                                        fit: BoxFit.cover,
                                        width: 100,
                                        height: 100,
                                        loadingBuilder:
                                            (context, child, loadingProgress) {
                                          if (loadingProgress == null)
                                            return child;
                                          return Center(
                                            child: CircularProgressIndicator(
                                              value: loadingProgress
                                                          .expectedTotalBytes !=
                                                      null
                                                  ? loadingProgress
                                                          .cumulativeBytesLoaded /
                                                      loadingProgress
                                                          .expectedTotalBytes!
                                                  : null,
                                              strokeWidth: 2,
                                            ),
                                          );
                                        },
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return const Center(
                                            child: Icon(
                                              Icons.image_not_supported,
                                              color: Colors.grey,
                                              size: 32,
                                            ),
                                          );
                                        },
                                      ),
                                    )
                                  : const Center(
                                      child: Icon(
                                        Icons.image,
                                        color: Colors.grey,
                                        size: 32,
                                      ),
                                    ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 3),
                                decoration: const BoxDecoration(
                                  color: Colors.amber,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(12),
                                    bottomRight: Radius.circular(12),
                                  ),
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4),
                                    child: Text(
                                      widget.formatToRupiah(
                                          widget.item.hargaPerhari),
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
                                'BARANG',
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                widget.item.namaBarang,
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
                                widget.formatToRupiah(widget.item.subtotal),
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
                          mainAxisAlignment:
                              MainAxisAlignment.center, // Center vertically
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
                                      if (widget.item.kuantitas > 1) {
                                        widget.onQuantityChanged(
                                            widget.item.kuantitas - 1);
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
                                      '${widget.item.kuantitas}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      widget.onQuantityChanged(
                                          widget.item.kuantitas + 1);
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
