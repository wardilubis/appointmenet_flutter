import 'package:flutter/material.dart';
import '../models/appointment.dart';

class StatusFilterChips extends StatelessWidget {
  final AppointmentStatus? selectedStatus;
  final Function(AppointmentStatus?) onStatusSelected;

  const StatusFilterChips({
    super.key,
    required this.selectedStatus,
    required this.onStatusSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            // All filter chip
            FilterChip(
              label: const Text('All'),
              selected: selectedStatus == null,
              onSelected: (selected) {
                onStatusSelected(null);
              },
              backgroundColor: Colors.grey[100],
              selectedColor: Theme.of(
                context,
              ).colorScheme.primary.withOpacity(0.2),
              checkmarkColor: Theme.of(context).colorScheme.primary,
            ),

            const SizedBox(width: 8),

            // Status filter chips
            ...AppointmentStatus.values.map((status) {
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: FilterChip(
                  label: Text(_getStatusLabel(status)),
                  selected: selectedStatus == status,
                  onSelected: (selected) {
                    onStatusSelected(selected ? status : null);
                  },
                  backgroundColor: _getStatusColor(status).withOpacity(0.1),
                  selectedColor: _getStatusColor(status).withOpacity(0.2),
                  checkmarkColor: _getStatusColor(status),
                  side: BorderSide(
                    color: _getStatusColor(status).withOpacity(0.3),
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  String _getStatusLabel(AppointmentStatus status) {
    switch (status) {
      case AppointmentStatus.pending:
        return 'Pending';
      case AppointmentStatus.approved:
        return 'Approved';
      case AppointmentStatus.rejected:
        return 'Rejected';
      case AppointmentStatus.completed:
        return 'Completed';
    }
  }

  Color _getStatusColor(AppointmentStatus status) {
    switch (status) {
      case AppointmentStatus.pending:
        return Colors.orange;
      case AppointmentStatus.approved:
        return Colors.green;
      case AppointmentStatus.rejected:
        return Colors.red;
      case AppointmentStatus.completed:
        return Colors.blue;
    }
  }
}
