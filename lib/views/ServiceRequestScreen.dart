import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gear/controllers/servicerequest_controller.dart';
import 'package:intl/intl.dart';

class ServiceRequestForm extends StatelessWidget {
  final ServiceRequestController controller = Get.put(ServiceRequestController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Service Request Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Service Type
              Text('Service Type'),
              DropdownButtonFormField<int>(
                value: controller.serviceType.value,
                onChanged: (value) {
                  if (value != null) controller.serviceType.value = value;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                ),
                items: controller.serviceTypes.map((type) {
                  return DropdownMenuItem<int>(
                    value: type.id,
                    child: Text(type.name),
                  );
                }).toList(),
              ),
              SizedBox(height: 16),

              // Appointment Date
              Text('Appointment Date'),
              TextFormField(
                readOnly: true,
                controller: TextEditingController(
                  text: DateFormat('yyyy-MM-dd').format(controller.appointmentTime.value),
                ),
                decoration: InputDecoration(
                  hintText: 'Select a date',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                ),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: controller.appointmentTime.value,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                  if (pickedDate != null) {
                    controller.appointmentTime.value = pickedDate;
                  }
                },
              ),
              SizedBox(height: 16),

              // Mechanics
              Text('Mechanic'),
              DropdownButtonFormField<int>(
                value: controller.selectedMechanic.value,
                onChanged: (value) {
                  if (value != null) controller.selectedMechanic.value = value;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                ),
                items: controller.mechanics.map((mech) {
                  return DropdownMenuItem<int>(
                    value: mech.id,
                    child: Text(mech.name),
                  );
                }).toList(),
              ),
              SizedBox(height: 24),

              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.submitServiceRequest,
                  child: Text('Submit Request'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
