import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../models/appointment.dart';
import '../providers/appointment_provider.dart';

class AppointmentDetailScreen extends StatelessWidget {
  final Appointment appointment;

  const AppointmentDetailScreen({
    super.key,
    required this.appointment,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointment Details'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              _handleMenuAction(context, value);
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'edit',
                child: Row(
                  children: [
                    Icon(Icons.edit),
                    SizedBox(width: 8),
                    Text('Edit'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(Icons.delete, color: Colors.red),
                    SizedBox(width: 8),
                    Text('Delete', style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _getStatusColor(appointment.appointmentStatus).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _getStatusColor(appointment.appointmentStatus).withOpacity(0.3),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    _getStatusIcon(appointment.appointmentStatus),
                    color: _getStatusColor(appointment.appointmentStatus),
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    appointment.status.toUpperCase(),
                    style: TextStyle(
                      color: _getStatusColor(appointment.appointmentStatus),
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const Spacer(),
                  if (appointment.appointmentStatus == AppointmentStatus.pending) ...[
                    _buildStatusButton(context, 'Approve', AppointmentStatus.approved),
                    const SizedBox(width: 8),
                    _buildStatusButton(context, 'Reject', AppointmentStatus.rejected),
                  ],
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Appointment Details
            _buildDetailCard(
              'Applicant Information',
              [
                _buildDetailRow('Name', appointment.namaPemohon),
                _buildDetailRow('Email', appointment.emailPemohon),
                _buildDetailRow('Phone', appointment.nomorHpPemohon),
              ],
            ),
            
            const SizedBox(height: 16),
            
            _buildDetailCard(
              'Appointment Details',
              [
                _buildDetailRow('Professor', appointment.namaProfesor),
                _buildDetailRow('Date', DateFormat('EEEE, MMM dd, yyyy').format(appointment.hari)),
                _buildDetailRow('Time', appointment.waktu),
              ],
            ),
            
            const SizedBox(height: 16),
            
            _buildDetailCard(
              'Timestamps',
              [
                _buildDetailRow('Created', DateFormat('MMM dd, yyyy - HH:mm').format(appointment.createdAt)),
                _buildDetailRow('Updated', DateFormat('MMM dd, yyyy - HH:mm').format(appointment.updatedAt)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailCard(String title, List<Widget> children) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusButton(BuildContext context, String label, AppointmentStatus status) {
    return ElevatedButton(
      onPressed: () => _updateStatus(context, status),
      style: ElevatedButton.styleFrom(
        backgroundColor: _getStatusColor(status),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      child: Text(label),
    );
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

  IconData _getStatusIcon(AppointmentStatus status) {
    switch (status) {
      case AppointmentStatus.pending:
        return Icons.pending;
      case AppointmentStatus.approved:
        return Icons.check_circle;
      case AppointmentStatus.rejected:
        return Icons.cancel;
      case AppointmentStatus.completed:
        return Icons.done_all;
    }
  }

  void _updateStatus(BuildContext context, AppointmentStatus status) async {
    final provider = context.read<AppointmentProvider>();
    final success = await provider.updateAppointmentStatus(
      appointment.id,
      status.name,
    );

    if (context.mounted) {
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Appointment ${status.name} successfully'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to update appointment status'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _handleMenuAction(BuildContext context, String action) {
    switch (action) {
      case 'edit':
        // TODO: Navigate to edit screen
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Edit functionality coming soon')),
        );
        break;
      case 'delete':
        _showDeleteConfirmation(context);
        break;
    }
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Appointment'),
        content: const Text('Are you sure you want to delete this appointment? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              final provider = context.read<AppointmentProvider>();
              final success = await provider.deleteAppointment(appointment.id);
              
              if (context.mounted) {
                if (success) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Appointment deleted successfully'),
                      backgroundColor: Colors.green,
                    ),
                  );
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Failed to delete appointment'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}