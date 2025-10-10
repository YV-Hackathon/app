import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/church_detail_provider.dart';
import '../../domain/entities/church_detail.dart';

/// Example widget showing how to use the new church API endpoint
/// GET /api/v1/churches/{church_id}
class ChurchApiUsageExample extends ConsumerWidget {
  final int churchId;

  const ChurchApiUsageExample({super.key, required this.churchId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final churchDetailAsync = ref.watch(churchDetailNotifierProvider(churchId));

    return Scaffold(
      appBar: AppBar(title: const Text('Church Details')),
      body: churchDetailAsync.when(
        data: (churchDetail) {
          if (churchDetail == null) {
            return const Center(child: Text('Church not found'));
          }
          return _ChurchDetailView(churchDetail: churchDetail);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error:
            (error, stackTrace) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    'Error loading church details',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    error.toString(),
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      ref.invalidate(churchDetailNotifierProvider(churchId));
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
      ),
    );
  }
}

class _ChurchDetailView extends StatelessWidget {
  final ChurchDetail churchDetail;

  const _ChurchDetailView({required this.churchDetail});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Church Header
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    churchDetail.name,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    churchDetail.denomination,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  if (churchDetail.description != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      churchDetail.description!,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Contact Information
          if (churchDetail.address != null ||
              churchDetail.phone != null ||
              churchDetail.email != null ||
              churchDetail.website != null) ...[
            _SectionCard(
              title: 'Contact Information',
              children: [
                if (churchDetail.address != null)
                  _InfoRow(
                    icon: Icons.location_on,
                    label: 'Address',
                    value: churchDetail.address!.fullAddress,
                  ),
                if (churchDetail.phone != null)
                  _InfoRow(
                    icon: Icons.phone,
                    label: 'Phone',
                    value: churchDetail.phone!,
                  ),
                if (churchDetail.email != null)
                  _InfoRow(
                    icon: Icons.email,
                    label: 'Email',
                    value: churchDetail.email!,
                  ),
                if (churchDetail.website != null)
                  _InfoRow(
                    icon: Icons.web,
                    label: 'Website',
                    value: churchDetail.website!,
                  ),
              ],
            ),
            const SizedBox(height: 16),
          ],

          // Church Information
          _SectionCard(
            title: 'Church Information',
            children: [
              if (churchDetail.foundedYear != null)
                _InfoRow(
                  icon: Icons.calendar_today,
                  label: 'Founded',
                  value: churchDetail.foundedYear.toString(),
                ),
              if (churchDetail.membershipCount != null)
                _InfoRow(
                  icon: Icons.people,
                  label: 'Membership',
                  value: '${churchDetail.membershipCount} members',
                ),
              _InfoRow(
                icon: Icons.info,
                label: 'Status',
                value: churchDetail.isActive ? 'Active' : 'Inactive',
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Service Times
          if (churchDetail.serviceTimes != null) ...[
            _SectionCard(
              title: 'Service Times',
              children: [
                if (churchDetail.serviceTimes!.sunday != null)
                  _InfoRow(
                    icon: Icons.schedule,
                    label: 'Sunday',
                    value: churchDetail.serviceTimes!.sunday!.join(', '),
                  ),
                if (churchDetail.serviceTimes!.weekdays != null)
                  _InfoRow(
                    icon: Icons.schedule,
                    label: 'Weekdays',
                    value: churchDetail.serviceTimes!.weekdays!.join(', '),
                  ),
              ],
            ),
            const SizedBox(height: 16),
          ],

          // Social Media
          if (churchDetail.socialMedia != null &&
              churchDetail.socialMedia!.activeSocialMedia.isNotEmpty) ...[
            _SectionCard(
              title: 'Social Media',
              children: [
                Text(
                  'Available on: ${churchDetail.socialMedia!.activeSocialMedia.join(', ')}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _SectionCard({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Theme.of(context).primaryColor),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w500),
                ),
                Text(value, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
