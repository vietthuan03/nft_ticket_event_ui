import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../utility/app_theme.dart';

class UploadEvent extends StatefulWidget {
  const UploadEvent({super.key});

  @override
  State<UploadEvent> createState() => _UploadEventState();
}

class _UploadEventState extends State<UploadEvent> {
  final TextEditingController _eventNameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _eventDetailController = TextEditingController();

  DateTime? _startDate;
  DateTime? _endDate;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  File? _selectedImage;
  String? _selectedCategory;

  final ImagePicker _picker = ImagePicker();

  final List<String> categories = [
    'Concert',
    "Music",
    "Sports",
    "Conference",
    "Art",
    "Technology",
    "Education"
  ];
  Future _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 500,
      maxHeight: 500,
    );
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
        return Scaffold(
          appBar: AppBar(
            // foregroundColor: Colors.black,
            foregroundColor: theme.colorScheme.onPrimary,
            title: Text(
              "Add New Event",
              style: theme.textTheme.titleLarge?.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      theme.colorScheme.secondary,
                      theme.colorScheme.surface,
                      theme.scaffoldBackgroundColor,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: _pickImage,
                          child: Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                              border: Border.all(
                                // color: Colors.black45,
                                color: theme.colorScheme.onSurface,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: _selectedImage == null
                                ? const Icon(Icons.camera_alt_outlined)
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.file(
                                      _selectedImage!,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _eventNameController,
                          decoration: InputDecoration(
                            labelText: 'Event Name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _priceController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Price (USD)',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        DropdownButtonFormField<String>(
                          value: _selectedCategory,
                          items: categories
                              .map(
                                (category) => DropdownMenuItem<String>(
                                  value: category,
                                  child: Text(category),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedCategory = value;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Select Category',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        GestureDetector(
                          onTap: () async {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return StatefulBuilder(
                                  builder: (context, setDialogState) {
                                    return AlertDialog(
                                      title: Text(
                                        'Pick Event Date and Time',
                                        style: theme.textTheme.titleLarge,
                                      ),
                                      content: SizedBox(
                                        width: MediaQuery.of(context).size.width *
                                            0.8,
                                        height: 400,
                                        child: Column(
                                          children: [
                                            Expanded(
                                              child: SfDateRangePicker(
                                                selectionMode:
                                                    DateRangePickerSelectionMode
                                                        .range,
                                                minDate: DateTime
                                                    .now(), // Minimum selectable date
                                                onSelectionChanged:
                                                    (DateRangePickerSelectionChangedArgs
                                                        args) {
                                                  if (args.value
                                                      is PickerDateRange) {
                                                    setDialogState(() {
                                                      _startDate =
                                                          args.value.startDate;
                                                      _endDate = args
                                                              .value.endDate ??
                                                          args.value.startDate;
                                                    });
                                                    // Update parent state
                                                    setState(() {});
                                                  }
                                                },
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            ElevatedButton(
                                              onPressed: () async {
                                                final TimeOfDay? pickedTime =
                                                    await showTimePicker(
                                                  context: context,
                                                  initialTime: _startTime ??
                                                      TimeOfDay.now(),
                                                );
                                                if (pickedTime != null) {
                                                  // selectedTime minimum time
                                                  if (pickedTime.hour <
                                                          TimeOfDay.now().hour ||
                                                      (pickedTime.hour ==
                                                              TimeOfDay.now()
                                                                  .hour &&
                                                          pickedTime.minute <
                                                              TimeOfDay.now()
                                                                  .minute)) {
                                                    ScaffoldMessenger.of(context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        backgroundColor:
                                                            Colors.red,
                                                        content: Text(
                                                          'You cannot pick a past time!',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                    return;
                                                  }
                
                                                  setDialogState(() {
                                                    _startTime = pickedTime;
                                                  });
                                                  // Update parent state
                                                  setState(() {});
                                                }
                                              },
                                              child: Text(
                                                _startTime != null
                                                    ? 'Start Time: ${_startTime!.format(context)}'
                                                    : 'Pick Start Time',
                                              ),
                                            ),
                                            ElevatedButton(
                                              onPressed: () async {
                                                final TimeOfDay? pickedTime =
                                                    await showTimePicker(
                                                  context: context,
                                                  initialTime:
                                                      _endTime ?? TimeOfDay.now(),
                                                );
                                                if (pickedTime != null) {
                                                  // Membatasi waktu untuk tidak memilih waktu yang sudah lewat dari waktu saat ini
                                                  if (pickedTime.hour <
                                                          TimeOfDay.now().hour ||
                                                      (pickedTime.hour ==
                                                              TimeOfDay.now()
                                                                  .hour &&
                                                          pickedTime.minute <
                                                              TimeOfDay.now()
                                                                  .minute)) {
                                                    ScaffoldMessenger.of(context)
                                                        .showSnackBar(SnackBar(
                                                            content: Text(
                                                                'You cannot pick a past time!')));
                                                    return;
                                                  }
                
                                                  setDialogState(() {
                                                    _endTime = pickedTime;
                                                  });
                                                  // Update parent state
                                                  setState(() {});
                                                }
                                              },
                                              child: Text(
                                                _endTime != null
                                                    ? 'End Time: ${_endTime!.format(context)}'
                                                    : 'Pick End Time',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: theme.colorScheme.onSurface,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    _startDate != null &&
                                            _endDate != null &&
                                            _startTime != null &&
                                            _endTime != null
                                        ? 'Start: ${_startDate!.toLocal().toIso8601String().split('T')[0]} ${_startTime!.format(context)}\n'
                                            'End: ${_endDate!.toLocal().toIso8601String().split('T')[0]} ${_endTime!.format(context)}'
                                        : 'Pick Date & Time Range',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: theme.colorScheme.onSurface,
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.calendar_today,
                                  color: theme.colorScheme.onSurface,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _eventDetailController,
                          maxLines: 4,
                          decoration: InputDecoration(
                            labelText: 'Event Details',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Container(
                          height: 60,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: const Color(0xff6351ec),
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xff6351ec).withOpacity(0.3),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                if (_eventNameController.text.isEmpty ||
                                    _selectedImage == null ||
                                    _priceController.text.isEmpty ||
                                    _selectedCategory == null ||
                                    _startDate == null ||
                                    _startTime == null ||
                                    _endDate == null ||
                                    _endTime == null ||
                                    _eventDetailController.text.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Text(
                                        'Please fill in all fields',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  );
                                } else {
                                  //logic to add event
                
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text('Event Added Successfully!')),
                                  );
                
                                  setState(() {
                                    _eventNameController.clear();
                                    _priceController.clear();
                                    _selectedCategory = null;
                                    _startDate = null;
                                    _endDate = null;
                                    _startTime = null;
                                    _endTime = null;
                                    _selectedImage = null;
                                    _eventDetailController.clear();
                                  });
                                }
                              },
                              borderRadius: BorderRadius.circular(12),
                              child: const Center(
                                child: Text(
                                  'Add Event',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
  }
}
