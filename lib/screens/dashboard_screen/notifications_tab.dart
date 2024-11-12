import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NotificationsTab extends ConsumerStatefulWidget {
  const NotificationsTab({super.key});

  @override
  ConsumerState<NotificationsTab> createState() => _NotificationsTabState();
}

class _NotificationsTabState extends ConsumerState<NotificationsTab> {
  // Sample data - replace with your actual data source
  final List<NotificationItem> _notifications = [
    NotificationItem(
      type: NotificationType.alert,
      title: 'System Update',
      message:
          'A new version of the app is available. Update now to get the latest features.',
      time: DateTime.now().subtract(const Duration(minutes: 5)),
      isRead: false,
    ),
    NotificationItem(
      type: NotificationType.achievement,
      title: 'Achievement Unlocked!',
      message: 'You\'ve completed 10 tasks this week!',
      time: DateTime.now().subtract(const Duration(hours: 2)),
      isRead: false,
    ),
    NotificationItem(
      type: NotificationType.message,
      title: 'New Message',
      message: 'Sarah: Hey, have you checked the latest design updates?',
      time: DateTime.now().subtract(const Duration(hours: 3)),
      isRead: true,
    ),
    NotificationItem(
      type: NotificationType.reminder,
      title: 'Task Due Soon',
      message: 'Project presentation is due in 2 hours',
      time: DateTime.now().subtract(const Duration(hours: 4)),
      isRead: true,
    ),
    // Add more notifications as needed
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            pinned: true,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tr('Notifications'),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  tr('{count} unread', args: ["2"]),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
            actions: [
              IconButton(
                icon: const Icon(FontAwesomeIcons.check),
                onPressed: () {
                  // Mark all as read
                },
                tooltip: tr('Mark all as read'),
              ),
              IconButton(
                icon: const Icon(FontAwesomeIcons.sliders),
                onPressed: () {
                  // Show filter options
                },
                tooltip: tr('Filter notifications'),
              ),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (index == 0) {
                    return _NotificationDateGroup(
                      title: tr('Today'),
                      notifications: _notifications
                          .where((n) => n.time.isAfter(
                              DateTime.now().subtract(const Duration(days: 1))))
                          .toList(),
                    );
                  } else if (index == 1) {
                    return _NotificationDateGroup(
                      title: tr('Earlier'),
                      notifications: _notifications
                          .where((n) => !n.time.isAfter(
                              DateTime.now().subtract(const Duration(days: 1))))
                          .toList(),
                    );
                  }
                  return null;
                },
                childCount: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NotificationDateGroup extends StatelessWidget {
  final String title;
  final List<NotificationItem> notifications;

  const _NotificationDateGroup({
    required this.title,
    required this.notifications,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (notifications.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ...notifications.map((notification) => _NotificationCard(
              notification: notification,
              onTap: () {
                // Handle notification tap
              },
            )),
        const SizedBox(height: 16),
      ],
    );
  }
}

class _NotificationCard extends StatelessWidget {
  final NotificationItem notification;
  final VoidCallback onTap;

  const _NotificationCard({
    required this.notification,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            color: notification.isRead
                ? theme.cardColor
                : theme.colorScheme.primary.withOpacity(0.05),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: theme.colorScheme.outline.withOpacity(0.1),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _NotificationIcon(type: notification.type),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              notification.title,
                              style: theme.textTheme.titleSmall?.copyWith(
                                fontWeight: notification.isRead
                                    ? FontWeight.w500
                                    : FontWeight.w600,
                              ),
                            ),
                          ),
                          Text(
                            _getTimeString(notification.time),
                            style: theme.textTheme.bodySmall?.copyWith(
                              color:
                                  theme.colorScheme.onSurface.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        notification.message,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.7),
                        ),
                      ),
                      if (!notification.isRead) ...[
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                // Mark as read
                              },
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text(tr('Mark as read')),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getTimeString(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inMinutes < 60) {
      return tr('{min}m ago', args: [difference.inMinutes.toString()]);
    } else if (difference.inHours < 24) {
      return tr('{hours}h ago', args: [difference.inHours.toString()]);
    } else {
      return DateFormat.MMMd().format(time);
    }
  }
}

class _NotificationIcon extends StatelessWidget {
  final NotificationType type;

  const _NotificationIcon({required this.type});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    IconData icon;
    Color color;

    switch (type) {
      case NotificationType.alert:
        icon = FontAwesomeIcons.circleInfo;
        color = theme.colorScheme.primary;
        break;
      case NotificationType.achievement:
        icon = FontAwesomeIcons.trophy;
        color = Colors.amber;
        break;
      case NotificationType.message:
        icon = FontAwesomeIcons.envelope;
        color = Colors.green;
        break;
      case NotificationType.reminder:
        icon = FontAwesomeIcons.bell;
        color = Colors.orange;
        break;
    }

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        icon,
        size: 20,
        color: color,
      ),
    );
  }
}

enum NotificationType {
  alert,
  achievement,
  message,
  reminder,
}

class NotificationItem {
  final NotificationType type;
  final String title;
  final String message;
  final DateTime time;
  final bool isRead;

  NotificationItem({
    required this.type,
    required this.title,
    required this.message,
    required this.time,
    required this.isRead,
  });
}
