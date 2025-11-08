import 'package:flutter/material.dart';

class TimeSlotsWidget extends StatelessWidget {
  const TimeSlotsWidget({
    super.key,
    required this.times,
    required this.selectedTimeSlot,
  });

  final List<List<String>> times;
  final String? selectedTimeSlot;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'اوقات الصباح',
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: times.map((time) {
              final timeKey = '${time[0]}-${time[1]}';
              final isSelected = selectedTimeSlot == timeKey;
              return GestureDetector(
                onTap: () {},

                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2A2535),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFF8B6B6B)
                          : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'صباحا ${time[0]}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.close, color: Colors.red, size: 12),
                      const SizedBox(width: 8),
                      Text(
                        'صباحا ${time[1]}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
