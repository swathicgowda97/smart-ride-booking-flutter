import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../models/ride_type.dart';
import '../../models/trip_model.dart';
import '../../models/trip_status.dart';
import '../../state/trip/trip_provider.dart';

class AddTripScreen extends ConsumerStatefulWidget {
  const AddTripScreen({super.key});

  @override
  ConsumerState<AddTripScreen> createState() => _AddTripScreenState();
}

class _AddTripScreenState extends ConsumerState<AddTripScreen> {
  final _formKey = GlobalKey<FormState>();
  final _pickupController = TextEditingController();
  final _dropController = TextEditingController();
  final _fareController = TextEditingController();

  RideType _rideType = RideType.mini;

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final trip = TripModel(
      id: const Uuid().v4(),
      pickupLocation: _pickupController.text,
      dropLocation: _dropController.text,
      rideType: _rideType,
      fare: double.parse(_fareController.text),
      status: TripStatus.requested,
      dateTime: DateTime.now(),
    );

    ref.read(tripProvider.notifier).addTrip(trip);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Book a Ride')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _pickupController,
                decoration: const InputDecoration(labelText: 'Pickup Location'),
                validator: (v) =>
                v == null || v.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _dropController,
                decoration: const InputDecoration(labelText: 'Drop Location'),
                validator: (v) =>
                v == null || v.isEmpty ? 'Required' : null,
              ),
              DropdownButtonFormField<RideType>(
                value: _rideType,
                decoration: const InputDecoration(labelText: 'Ride Type'),
                items: RideType.values
                    .map(
                      (type) => DropdownMenuItem(
                    value: type,
                    child: Text(type.name.toUpperCase()),
                  ),
                )
                    .toList(),
                onChanged: (v) => setState(() => _rideType = v!),
              ),
              TextFormField(
                controller: _fareController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Initial Fare'),
                validator: (v) =>
                v == null || double.tryParse(v) == null
                    ? 'Enter valid amount'
                    : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submit,
                child: const Text('Book Ride'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
