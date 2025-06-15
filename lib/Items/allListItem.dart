import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../Items/detailItem.dart';
import '../components/navbar.dart';
import '../providers/auth_provider.dart';
import '../providers/barang_provider.dart';
import '../providers/wishlist_provider.dart';
import '../models/models.dart';

void main() {
  runApp(const AllItemList());
}

class AllItemList extends StatelessWidget {
  const AllItemList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF445018),
        scaffoldBackgroundColor: const Color(0xFFF8F8F8),
      ),
      home: ItemCategory(),
    );
  }
}

class ItemCategory extends StatefulWidget {
  ItemCategory({Key? key}) : super(key: key);

  @override
  _ItemCategoryState createState() => _ItemCategoryState();
}

class _ItemCategoryState extends State<ItemCategory> {
  List<Barang> allItems = [];
  List<Barang> filteredItems = [];
  bool _isLoading = false;
  String? _error;

  final List<String> categories = [
    "All",
    "Tenda",
    "Alat Masak",
    "Sepatu",
    "Tas",
    "Aksesoris",
    "Pakaian"
  ];

  List<String> selectedCategories = [];
  RangeValues priceRange = const RangeValues(0, 1000000);
  List<int> selectedRatings = [];
  List<String> selectedLocations = [];
  List<String> selectedBrands = [];

  TextEditingController minPriceController = TextEditingController(text: "0");
  TextEditingController maxPriceController = TextEditingController(text: "1000000");

  @override
  void initState() {
    super.initState();
    _loadAllItems();
  }

  @override
  void dispose() {
    minPriceController.dispose();
    maxPriceController.dispose();
    super.dispose();
  }

  Future<void> _loadAllItems() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final barangProvider = Provider.of<BarangProvider>(context, listen: false);

    if (authProvider.isAuthenticated) {
      setState(() {
        _isLoading = true;
        _error = null;
      });

      await barangProvider.fetchAllBarang(authProvider.user!.userId);

      setState(() {
        _isLoading = false;
        allItems = List.from(barangProvider.allBarang);
        filteredItems = List.from(allItems);
        _error = barangProvider.error;
      });
    }
  }

  void _applyFilters() {
    setState(() {
      filteredItems = allItems.where((item) {
        // Category filter
        bool categoryMatch = selectedCategories.isEmpty || 
                            selectedCategories.contains("All") ||
                            _getCategoryName(item.kategoriId).any((cat) => selectedCategories.contains(cat));

        // Price filter
        bool priceMatch = item.hargaPerhari >= priceRange.start.round() &&
                         item.hargaPerhari <= priceRange.end.round();

        // Rating filter
        bool ratingMatch = selectedRatings.isEmpty ||
                          selectedRatings.any((rating) => item.meanReview >= rating && item.meanReview < rating + 1);

        return categoryMatch && priceMatch && ratingMatch;
      }).toList();
    });
  }

  List<String> _getCategoryName(int categoryId) {
    // Map category IDs to category names - you can adjust this based on your API
    Map<int, String> categoryMap = {
      1: "Tenda",
      2: "Alat Masak", 
      3: "Sepatu",
      4: "Tas",
      5: "Aksesoris",
      6: "Pakaian",
    };
    return [categoryMap[categoryId] ?? "Other"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Jelajahi Katalog Barang',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        hintText: 'Search here',
                        prefixIcon: Icon(Icons.search, color: Colors.grey),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 15),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: 8),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 10),
                      itemBuilder: (context, index) {                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              if (selectedCategories.contains(categories[index])) {
                                selectedCategories.remove(categories[index]);
                              } else {
                                selectedCategories.add(categories[index]);
                              }
                              _applyFilters(); // Apply filters when category changes
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: selectedCategories.contains(categories[index])
                                  ? const Color(0xFFA0B25E)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border:
                                  Border.all(color: const Color(0xFFA0B25E)),
                            ),
                            child: Text(
                              categories[index],
                              style: TextStyle(
                                color: selectedCategories.contains(categories[index])
                                    ? Colors.white
                                    : const Color(0xFFA0B25E),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      _showSortBottomSheet(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFFA0B25E)),
                      ),
                      child: const Icon(Icons.sort,
                          size: 18, color: Color(0xFFA0B25E)),
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      _showFilterBottomSheet(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFFA0B25E)),
                      ),
                      child: const Icon(FontAwesomeIcons.filter,
                          size: 18, color: Color(0xFFA0B25E)),
                    ),
                  ),
                ],
              ),
            ),
          ),          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            sliver: _isLoading
                ? SliverToBoxAdapter(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(50),
                        child: CircularProgressIndicator(
                          color: Color(0xFFA0B25E),
                        ),
                      ),
                    ),
                  )
                : _error != null
                    ? SliverToBoxAdapter(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(50),
                            child: Column(
                              children: [
                                Text(
                                  'Error loading items: $_error',
                                  style: TextStyle(color: Colors.red),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 16),
                                ElevatedButton(
                                  onPressed: _loadAllItems,
                                  child: Text('Retry'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : filteredItems.isEmpty
                        ? SliverToBoxAdapter(
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(50),
                                child: Text(
                                  'No items found',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : SliverGrid(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                return _buildBarangItem(filteredItems[index], context, index);
                              },
                              childCount: filteredItems.length,
                            ),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.75,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                          ),
          ),
        ],
      ),
      bottomNavigationBar: buildBottomNavBar(context, currentIndex: 1),
    );
  }

  void _showSortBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Urutkan Berdasarkan',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                  const Divider(),
                  _buildSortOption(context, 'Terbaru', Icons.access_time),
                  _buildSortOption(context, 'Harga Tertinggi', Icons.arrow_upward),
                  _buildSortOption(context, 'Harga Terendah', Icons.arrow_downward),
                  _buildSortOption(context, 'Rating Tertinggi', Icons.star),
                  _buildSortOption(context, 'Paling Populer', Icons.favorite),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFA0B25E),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Terapkan',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildSortOption(BuildContext context, String title, IconData icon) {
    return InkWell(
      onTap: () {
        // Implementasi logika sort
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFFA0B25E)),
            const SizedBox(width: 15),
            Text(
              title,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.85,
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Filter',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                  const Divider(),
                  Expanded(
                    child: ListView(
                      children: [
                        // Categories
                        _buildFilterSection(
                          context,
                          "Kategori",
                          ["Tenda", "Alat Masak", "Sepatu", "Tas", "Aksesoris", "Pakaian"],
                          selectedCategories,
                          (category, isSelected) {
                            setModalState(() {
                              if (isSelected) {
                                selectedCategories.remove(category);
                              } else {
                                selectedCategories.add(category);
                              }
                            });
                          },
                        ),
                        const SizedBox(height: 15),
                        
                        // Price Range
                        const Text(
                          "Rentang Harga",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: minPriceController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: "Min",
                                  prefixText: "Rp. ",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onChanged: (value) {
                                  double minValue = double.tryParse(value) ?? 0;
                                  setModalState(() {
                                    priceRange = RangeValues(
                                      minValue,
                                      priceRange.end,
                                    );
                                  });
                                },
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextField(
                                controller: maxPriceController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: "Max",
                                  prefixText: "Rp. ",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onChanged: (value) {
                                  double maxValue = double.tryParse(value) ?? 1000000;
                                  setModalState(() {
                                    priceRange = RangeValues(
                                      priceRange.start,
                                      maxValue,
                                    );
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        RangeSlider(
                          values: priceRange,
                          min: 0,
                          max: 1000000,
                          divisions: 10,
                          activeColor: const Color(0xFFA0B25E),
                          labels: RangeLabels(
                            "Rp.${priceRange.start.round()}",
                            "Rp.${priceRange.end.round()}",
                          ),
                          onChanged: (values) {
                            setModalState(() {
                              priceRange = values;
                              minPriceController.text = values.start.round().toString();
                              maxPriceController.text = values.end.round().toString();
                            });
                          },
                        ),
                        const SizedBox(height: 15),
                        
                        // Rating
                        const Text(
                          "Rating",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(5, (index) {
                            final rating = index + 1;
                            final isSelected = selectedRatings.contains(rating);
                            return InkWell(
                              onTap: () {
                                setModalState(() {
                                  if (isSelected) {
                                    selectedRatings.remove(rating);
                                  } else {
                                    selectedRatings.add(rating);
                                  }
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                  color: isSelected ? const Color(0xFFA0B25E) : Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: const Color(0xFFA0B25E)),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: isSelected ? Colors.white : Colors.amber,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      "$rating",
                                      style: TextStyle(
                                        color: isSelected ? Colors.white : Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                        const SizedBox(height: 15),
                        
                        // Lokasi
                        _buildFilterSection(
                          context,
                          "Lokasi",
                          ["Jakarta", "Bandung", "Surabaya", "Yogyakarta", "Bali", "Medan"],
                          selectedLocations,
                          (location, isSelected) {
                            setModalState(() {
                              if (isSelected) {
                                selectedLocations.remove(location);
                              } else {
                                selectedLocations.add(location);
                              }
                            });
                          },
                        ),
                        const SizedBox(height: 15),
                        
                        // Brand
                        _buildFilterSection(
                          context,
                          "Brand",
                          ["Eiger", "Consina", "Rei", "Avtech", "Osprey", "Deuter"],
                          selectedBrands,
                          (brand, isSelected) {
                            setModalState(() {
                              if (isSelected) {
                                selectedBrands.remove(brand);
                              } else {
                                selectedBrands.add(brand);
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              setModalState(() {
                                selectedCategories.clear();
                                selectedRatings.clear();
                                selectedLocations.clear();
                                selectedBrands.clear();
                                priceRange = const RangeValues(0, 1000000);
                                minPriceController.text = "0";
                                maxPriceController.text = "1000000";
                              });
                            },
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Color(0xFFA0B25E)),
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              'Reset',
                              style: TextStyle(
                                color: Color(0xFFA0B25E),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(                            onPressed: () {
                              // Terapkan filter
                              _applyFilters();
                              Navigator.pop(context);
                              // Refresh state
                              setState(() {});
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFA0B25E),
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              'Terapkan',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildFilterSection(
    BuildContext context,
    String title,
    List<String> items,
    List<String> selectedItems,
    Function(String, bool) onToggle,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: items.map((item) {
            final isSelected = selectedItems.contains(item);
            return GestureDetector(
              onTap: () => onToggle(item, isSelected),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFFA0B25E) : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color.fromARGB(255, 69, 79, 31)),
                ),
                child: Text(
                  item,
                  style: TextStyle(
                    color: isSelected ? Colors.white : const Color.fromARGB(255, 67, 77, 29),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
  Widget _buildBarangItem(Barang barang, BuildContext context, int index) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final wishlistProvider = Provider.of<WishlistProvider>(context, listen: false);
    
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const DetailItem()),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image section
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      color: Colors.grey[200],
                    ),
                    child: barang.foto != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                            child: Image.network(
                              barang.foto!,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return _buildPlaceholderImage();
                              },
                            ),
                          )
                        : _buildPlaceholderImage(),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: GestureDetector(
                      onTap: () async {
                        if (authProvider.isAuthenticated) {
                          if (barang.isWishlist == true) {
                            // Remove from wishlist
                            await wishlistProvider.removeFromWishlist(
                              authProvider.user!.userId, 
                              barang.id
                            );
                          } else {
                            // Add to wishlist
                            await wishlistProvider.addToWishlist(
                              authProvider.user!.userId, 
                              barang.id
                            );
                          }
                          _loadAllItems(); // Refresh the list
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          barang.isWishlist == true ? Icons.favorite : Icons.favorite_border,
                          color: Colors.red,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Info section
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      barang.namaBarang,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          NumberFormat.currency(locale: 'id', symbol: 'Rp', decimalDigits: 0)
                              .format(barang.hargaPerhari),
                          style: TextStyle(
                            color: Color(0xFFA0B25E),
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 14),
                            const SizedBox(width: 2),
                            Text(
                              barang.meanReview.toStringAsFixed(1),
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey[600],
                              ),
                            ),
                            Text(
                              ' (${barang.totalReview})',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey[600],
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
      ),
    );
  }

  Widget _buildPlaceholderImage() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        color: Colors.grey[200],
      ),
      child: Icon(
        Icons.image,
        color: Colors.grey[400],
        size: 40,
      ),
    );
  }
}