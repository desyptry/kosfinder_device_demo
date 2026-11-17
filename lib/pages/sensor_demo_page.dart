import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class SensorDemoPage extends StatefulWidget {
  const SensorDemoPage({super.key});

  @override
  State<SensorDemoPage> createState() => _SensorDemoPageState();
}

class _SensorDemoPageState extends State<SensorDemoPage> {
  StreamSubscription<AccelerometerEvent>? _subscription;
  AccelerometerEvent? _lastEvent;
  String _status = 'Menunggu data sensor...';

  @override
  void initState() {
    super.initState();
    _startListening();
  }

  void _startListening() {
    _subscription = accelerometerEventStream().listen(
      (event) {
        if (!mounted) return;
        setState(() {
          _lastEvent = event;
          final magnitude = math.sqrt(
            event.x * event.x + event.y * event.y + event.z * event.z,
          );
          _status = magnitude > 12
              ? 'Perangkat bergerak (magnitude: ${magnitude.toStringAsFixed(2)} m/s²)'
              : 'Perangkat stabil (magnitude: ${magnitude.toStringAsFixed(2)} m/s²)';
        });
      },
      onError: (error) {
        if (!mounted) return;
        setState(() => _status = 'Sensor error: $error');
      },
      cancelOnError: false,
    );
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final event = _lastEvent;
    return Scaffold(
      appBar: AppBar(title: const Text('Demo Sensor Accelerometer')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Data accelerometer real-time (m/s²). '
              'Goyangkan perangkat untuk melihat perubahan.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 20),
            if (event == null)
              const Center(child: CircularProgressIndicator())
            else ...[
              _SensorRow(label: 'X', value: event.x),
              _SensorRow(label: 'Y', value: event.y),
              _SensorRow(label: 'Z', value: event.z),
              const SizedBox(height: 20),
              Card(
                color: Theme.of(context).colorScheme.secondaryContainer,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    _status,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
            const Spacer(),
            const Text(
              'Catatan: sensor membaca gerakan perangkat, bukan posisi absolut. '
              'Emulator mungkin tidak menyediakan data sensor asli.',
              style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}

class _SensorRow extends StatelessWidget {
  const _SensorRow({required this.label, required this.value});
  final String label;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text(value.toStringAsFixed(3), style: const TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}