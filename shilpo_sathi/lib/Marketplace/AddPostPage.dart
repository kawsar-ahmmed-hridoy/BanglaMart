import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'MarketplacePage.dart';

class AddPostPage extends StatefulWidget {
  final Function(Product) onPostAdded;

  AddPostPage({required this.onPostAdded});

  @override
  _AddPostPageState createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _sellerNameController = TextEditingController();
  final TextEditingController _sellerContactController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _videoLinkController = TextEditingController();
  final TextEditingController _historyController = TextEditingController();
  final TextEditingController _relatedLinkController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;
  String _selectedCategory = 'Clothing';

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate() && _selectedImage != null) {
      final product = Product(
        name: _nameController.text,
        price: _priceController.text,
        imageAsset: _selectedImage!.path,
        description: _descriptionController.text,
        sellerName: _sellerNameController.text,
        sellerContact: _sellerContactController.text,
        location: _locationController.text,
        category: _selectedCategory,
        videoLink: _videoLinkController.text,
        history: _historyController.text,
        relatedLink: _relatedLinkController.text,
      );
      widget.onPostAdded(product);
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please complete all fields and select an image.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FA),
      appBar: AppBar(
        title: const Text('Add New Product'),
        backgroundColor: const Color(0xFF252C35),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(15),
                    image: _selectedImage != null
                        ? DecorationImage(
                      image: FileImage(_selectedImage!),
                      fit: BoxFit.cover,
                    )
                        : null,
                  ),
                  child: _selectedImage == null
                      ? const Center(
                    child: Icon(Icons.add_a_photo, size: 40, color: Colors.grey),
                  )
                      : null,
                ),
              ),
              const SizedBox(height: 20),
              _buildTextField(_nameController, 'Product Name', 'Enter product name'),
              _buildTextField(_priceController, 'Price', 'Enter product price', keyboard: TextInputType.number),
              _buildTextField(_descriptionController, 'Description', 'Enter description', maxLines: 3),
              _buildTextField(_sellerNameController, 'Seller Name', 'Enter seller name'),
              _buildTextField(_sellerContactController, 'Seller Contact', 'Enter contact info', keyboard: TextInputType.phone),
              _buildTextField(_locationController, 'Location', 'Enter product location'),
              _buildTextField(_videoLinkController, 'Video Link', 'Enter YouTube video link'),
              _buildTextField(_historyController, 'History', 'Enter artisan history'),
              _buildTextField(_relatedLinkController, 'Related Link', 'Enter related URL or article'),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: _dropdownDecoration('Category'),
                value: _selectedCategory,
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedCategory = value;
                    });
                  }
                },
                items: [
                  'Clothing',
                  'Handicraft',
                  'Jewelry',
                  'Woodwork',
                  'Pottery',
                  'Weaving',
                  'Painting',
                  'Embroidery',
                  'Calligraphy',
                  'Metal Craft',
                  'Recycled Art',
                  'Nature Art',
                  'Others'
                ].map((cat) => DropdownMenuItem(
                  value: cat,
                  child: Text(cat),
                ))
                    .toList(),
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF252C35),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: _submitForm,
                icon: const Icon(Icons.check_circle_outline),
                label: const Text('Submit Post', style: TextStyle(fontSize: 16)),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller,
      String label,
      String hint, {
        TextInputType keyboard = TextInputType.text,
        int maxLines = 1,
      }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboard,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }

  InputDecoration _dropdownDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}
