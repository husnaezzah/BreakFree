import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CapturePage extends StatefulWidget {
  @override
  _CapturePageState createState() => _CapturePageState();
}

class _CapturePageState extends State<CapturePage> {
  XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();
  String? selectedCategory;
  final categories = ['Physical Abuse', 'Emotional Abuse', 'Verbal Abuse', 'Financial Abuse'];
  int _selectedIndex = 2;

  void _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _imageFile = pickedFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[50],
      appBar: AppBar(
        backgroundColor: Colors.purple[100],
        title: Text('BreakFree.',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate back to HomePage when back arrow is pressed
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.chat_bubble_outline),
            onPressed: () {
              // Handle chat icon press
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Capture Section
              Text(
                'Capture',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Text('Report A Case'),
              SizedBox(height: 20),
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: _imageFile != null
                      ? Image.file(
                          File(_imageFile!.path),
                          fit: BoxFit.cover,
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.camera_alt, size: 50, color: Colors.grey),
                            SizedBox(height: 10),
                            Text('Or', style: TextStyle(color: Colors.black)),
                            ElevatedButton(
                              onPressed: _pickImage,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromARGB(255, 45, 15, 51),
                              ),
                              child: Text('Browse File', style: TextStyle(color: Colors.white)),
                            ),
                          ],
                        ),
                ),
              ),
              SizedBox(height: 30),

              // Details Section
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Details',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10),

              // Date Input
              TextField(
                decoration: InputDecoration(
                  labelText: "Date",
                  prefixIcon: Icon(Icons.calendar_today),
                  border: OutlineInputBorder(),
                ),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );

                  if (pickedDate != null) {
                    setState(() {
                      // Display date in mm/dd/yyyy format
                    });
                  }
                },
              ),
              SizedBox(height: 10),

              // Location Input
              TextField(
                decoration: InputDecoration(
                  labelText: 'Location',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),

              // Category Dropdown
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Select Category',
                  border: OutlineInputBorder(),
                ),
                value: selectedCategory,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedCategory = newValue;
                  });
                },
                items: categories.map((category) {
                  return DropdownMenuItem(
                    child: Text(category),
                    value: category,
                  );
                }).toList(),
              ),
              SizedBox(height: 10),

              // Description Input
              TextField(
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
              ),
              SizedBox(height: 10),

              // Checkbox for Privacy Policy
              Row(
                children: [
                  Checkbox(
                    value: true,
                    onChanged: (bool? value) {
                      // Handle checkbox action
                    },
                  ),
                  Text('I have read and agreed to '),
                  GestureDetector(
                    onTap: () {
                      // Handle link to Privacy Policy
                    },
                    child: Text(
                      'BreakFree\'s Privacy Policy.',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Draft and Submit Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Handle draft button press
                    },
                    style: ElevatedButton.styleFrom(
                     backgroundColor: const Color.fromARGB(255, 45, 15, 51),
                    ),
                    child: Text('Draft', style: TextStyle(color: Colors.white)),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Handle submit button press
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 45, 15, 51),
                    ),
                    child: Text('Submit', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.purple[100],
        selectedItemColor: Colors.black, // Set the selected item color
        unselectedItemColor: Colors.black, // Set the unselected item color
        currentIndex: _selectedIndex, // Keep track of the current index
        onTap: (int index) {
          setState(() {
            _selectedIndex = index; // Update the index when an icon is tapped
            if (index == 0) {
              Navigator.pop(context);  // Navigate back to Home if the Home icon is tapped
            }
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: _selectedIndex == 0 ? Colors.black : Colors.black),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Text(
              'SOS',
              style: TextStyle(
                color: Colors.red,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: _selectedIndex == 2 ? Colors.black : Colors.black), // Profile icon color
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}