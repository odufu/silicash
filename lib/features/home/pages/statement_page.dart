import 'package:flutter/material.dart';
import 'package:silicash_mobile/core/widgets/app_button.dart';
import 'package:silicash_mobile/core/widgets/costum_app_bar.dart';

class StatementOfAccountPage extends StatefulWidget {
  @override
  _StatementOfAccountPageState createState() => _StatementOfAccountPageState();
}

class _StatementOfAccountPageState extends State<StatementOfAccountPage> {
  DateTime? _startDate;
  DateTime? _endDate;
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  String? _selectedFileType;

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
          _startDateController.text = "${picked.toLocal()}".split(' ')[0];
        } else {
          _endDate = picked;
          _endDateController.text = "${picked.toLocal()}".split(' ')[0];
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Statement of account',
              style:  TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 8),
            Text(
              'Select Currency *',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            DropdownButtonFormField<String>(
              icon: Image.asset("assets/images/appAssets/arrowDown.png"),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.grey[200],
              ),
              items: <String>['USD', 'EUR', 'GBP', 'NGN'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (_) {},
              hint: Text('Select Currency'),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Start Date',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        controller: _startDateController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.grey[200],
                          hintText: 'Pick a date',
                          prefixIcon:
                              Image.asset("assets/images/appAssets/date.png"),
                        ),
                        readOnly: true,
                        onTap: () => _selectDate(context, true),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'End Date',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        controller: _endDateController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.grey[200],
                          hintText: 'Pick a date',
                          prefixIcon:
                              Image.asset("assets/images/appAssets/date.png"),
                        ),
                        readOnly: true,
                        onTap: () => _selectDate(context, false),
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedFileType = 'PDF';
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: _selectedFileType == 'PDF'
                            ? Colors.lightGreen[100]
                            : Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: _selectedFileType == 'PDF'
                              ? Colors.green
                              : Colors.grey,
                        ),
                      ),
                      child: Row(
                        children: [
                          Radio<String>(
                            value: 'PDF',
                            groupValue: _selectedFileType,
                            onChanged: (String? value) {
                              setState(() {
                                _selectedFileType = value;
                              });
                            },
                          ),
                          Text('PDF'),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedFileType = 'CSV';
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: _selectedFileType == 'CSV'
                            ? Colors.lightGreen[100]
                            : Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: _selectedFileType == 'CSV'
                              ? Colors.green
                              : Colors.grey,
                        ),
                      ),
                      child: Row(
                        children: [
                          Radio<String>(
                            value: 'CSV',
                            groupValue: _selectedFileType,
                            onChanged: (String? value) {
                              setState(() {
                                _selectedFileType = value;
                              });
                            },
                          ),
                          Text('CSV'),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Email',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.grey[200],
                hintText: 'Enter email address',
              ),
            ),
            SizedBox(height: 24),
            AppButton(
              buttonLabel: "Download Statement",
              onclick: () {},
            )
          ],
        ),
      ),
    );
  }
}
