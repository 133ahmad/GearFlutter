import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gear/controllers/servicerequest_controller.dart';
import 'package:intl/intl.dart';

class ServiceRequestForm extends StatelessWidget {
  final ServiceRequestController controller = Get.put(ServiceRequestController());
  final timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Service Request Form'),
      ),
      body: Obx(() => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.formKey,
          child: ListView(
            children: [
              // Service Type Dropdown
              Text('Service Type', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              DropdownButtonFormField<int>(
                value: controller.serviceTypeId.value,
                onChanged: (value) {
                  if (value != null) controller.serviceTypeId.value = value;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                ),
                items: controller.serviceTypes.map((type) {
                  return DropdownMenuItem<int>(
                    value: type.id,
                    child: Text(type.name),
                  );
                }).toList(),
                validator: (value) => value == null ? 'Please select a service type' : null,
              ),
              SizedBox(height: 20),

              // Mechanic Dropdown
              Text('Select Mechanic', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              DropdownButtonFormField<int>(
                value: controller.mechanicId.value,
                onChanged: (value) {
                  if (value != null) controller.mechanicId.value = value;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                ),
                items: controller.mechanics.map((mechanic) {
                  return DropdownMenuItem<int>(
                    value: mechanic.id,
                    child: Text(mechanic.name),
                  );
                }).toList(),
                validator: (value) => value == null ? 'Please select a mechanic' : null,
              ),
              SizedBox(height: 20),

              // Date Picker
              Text('Appointment Date', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              TextFormField(
                readOnly: true,
                controller: TextEditingController(
                  text: DateFormat('dd/MM/yyyy').format(controller.date.value),
                ),
                decoration: InputDecoration(
                  hintText: 'Select date',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                onTap: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: controller.date.value,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(Duration(days: 365)),
                  );
                  if (pickedDate != null) {
                    controller.date.value = pickedDate;
                  }
                },
                validator: (value) => value?.isEmpty ?? true ? 'Please select a date' : null,
              ),
              SizedBox(height: 20),

              // Time Picker
              Text('Appointment Time', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              TextFormField(
                readOnly: true,
                controller: timeController..text = controller.time.value,
                decoration: InputDecoration(
                  hintText: 'Select time',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  suffixIcon: Icon(Icons.access_time),
                ),
                onTap: () async {
                  final timeOfDay = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                    builder: (context, child) {
                      return MediaQuery(
                        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
                        child: child!,
                      );
                    },
                  );
                  if (timeOfDay != null) {
                    final formattedTime = timeOfDay.format(context);
                    controller.time.value = formattedTime;
                    timeController.text = formattedTime;
                  }
                },
                validator: (value) => value?.isEmpty ?? true ? 'Please select a time' : null,
              ),
              SizedBox(height: 30),

              // Submit Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  if (controller.formKey.currentState!.validate()) {
                    controller.submitServiceRequest();
                  }
                },
                child: controller.isLoading.value
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text('Submit Request', style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      )),
    );
  }
}