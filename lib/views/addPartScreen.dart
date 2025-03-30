import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gear/controllers/parts_controller.dart';

class AddPartScreen extends StatefulWidget {
  @override
  _AddPartScreenState createState() => _AddPartScreenState();
}

class _AddPartScreenState extends State<AddPartScreen> {
  final _formKey = GlobalKey<FormState>();
  final PartsController partsController = Get.find<PartsController>();

  String name = '';
  String description = '';
  double price = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add a Car Part')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Part Name'),
                onSaved: (value) => name = value!,
                validator: (value) => value!.isEmpty ? 'Enter a part name' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                onSaved: (value) => description = value!,
                validator: (value) => value!.isEmpty ? 'Enter a description' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                onSaved: (value) => price = double.tryParse(value!) ?? 0.0,
                validator: (value) => value!.isEmpty ? 'Enter a price' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    partsController.addPart(name, description, price);
                    Get.back();
                  }
                },
                child: Text('Add Part'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
