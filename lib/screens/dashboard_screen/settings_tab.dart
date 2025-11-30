import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:presetup/data/providers/auth_provider.dart';
import 'package:presetup/data/providers/theme_provider.dart';

class SettingsTab extends ConsumerWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: CustomScrollView(
        slivers: [
          SliverAppBar.medium(
            expandedHeight: 0,
            surfaceTintColor: Colors.transparent,
            backgroundColor: theme.scaffoldBackgroundColor,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                tr('Settings'),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      theme.colorScheme.primary.withOpacity(0.05),
                      theme.colorScheme.secondary.withOpacity(0.05),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(
                16, 0, 16, 100), // Added bottom padding for bottom bar
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _ProfileCard(),
                const SizedBox(height: 20),
                _SettingsSection(
                  title: tr('App Settings'),
                  icon: FontAwesomeIcons.gear,
                  children: [
                    _SettingsTile(
                      leading: Icon(
                        isDark ? FontAwesomeIcons.moon : FontAwesomeIcons.sun,
                        color: isDark ? Colors.blue : Colors.orange,
                        size: 20,
                      ),
                      title: tr('Dark Theme'),
                      subtitle: Text(
                        isDark
                            ? tr('Switch to light mode')
                            : tr('Switch to dark mode'),
                        style: theme.textTheme.bodySmall,
                      ),
                      trailing: Switch.adaptive(
                        value: isDark,
                        onChanged: (value) {
                          ref.read(themeProvider.notifier).setThemeMode(
                              value ? ThemeMode.dark : ThemeMode.light);
                        },
                      ),
                    ),
                    _SettingsTile(
                      leading: const Icon(FontAwesomeIcons.language, size: 20),
                      title: tr('Language'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'English',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color:
                                  theme.colorScheme.onSurface.withOpacity(0.6),
                            ),
                          ),
                          const SizedBox(width: 4),
                          Icon(
                            FontAwesomeIcons.chevronRight,
                            size: 16,
                            color: theme.colorScheme.onSurface.withOpacity(0.3),
                          ),
                        ],
                      ),
                      onTap: () {},
                    ),
                    _SettingsTile(
                      leading: const Icon(FontAwesomeIcons.bell, size: 20),
                      title: tr('Notifications'),
                      trailing: Icon(
                        FontAwesomeIcons.chevronRight,
                        size: 16,
                        color: theme.colorScheme.onSurface.withOpacity(0.3),
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _SettingsSection(
                  title: tr('Account'),
                  icon: FontAwesomeIcons.userGear,
                  children: [
                    _SettingsTile(
                      leading: const Icon(FontAwesomeIcons.userPen, size: 20),
                      title: tr('Edit Profile'),
                      onTap: () {},
                    ),
                    _SettingsTile(
                      leading: const Icon(FontAwesomeIcons.lock, size: 20),
                      title: tr('Privacy'),
                      onTap: () {},
                    ),
                    _SettingsTile(
                      leading: const Icon(FontAwesomeIcons.shield, size: 20),
                      title: tr('Security'),
                      onTap: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _SettingsSection(
                  title: tr('About'),
                  icon: FontAwesomeIcons.circleInfo,
                  children: [
                    _SettingsTile(
                      title: tr('App Version'),
                      trailing: Text(
                        '1.0.0 (1)',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.6),
                        ),
                      ),
                    ),
                    _SettingsTile(
                      leading: const Icon(FontAwesomeIcons.book, size: 20),
                      title: tr('Terms of Service'),
                      onTap: () {},
                    ),
                    _SettingsTile(
                      leading: const Icon(FontAwesomeIcons.shield, size: 20),
                      title: tr('Privacy Policy'),
                      onTap: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      ref.read(signInProvider.notifier).signOut();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade50,
                      foregroundColor: Colors.red,
                      elevation: 0,
                      minimumSize: const Size(double.infinity, 56),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    icon:
                        const Icon(FontAwesomeIcons.rightFromBracket, size: 20),
                    label: Text(
                      tr('Sign Out'),
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                'JD',
                style: TextStyle(
                  color: theme.colorScheme.primary,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'John Doe',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'john.doe@example.com',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
          Icon(
            FontAwesomeIcons.chevronRight,
            size: 20,
            color: theme.colorScheme.onSurface.withOpacity(0.3),
          ),
        ],
      ),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Widget> children;

  const _SettingsSection({
    required this.title,
    required this.icon,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(icon, size: 20, color: theme.colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          ...children,
        ],
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final Widget? leading;
  final String title;
  final Widget? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  const _SettingsTile({
    this.leading,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            if (leading != null) ...[
              leading!,
              const SizedBox(width: 16),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 4),
                    subtitle!,
                  ],
                ],
              ),
            ),
            if (trailing != null) ...[
              const SizedBox(width: 8),
              trailing!,
            ] else if (onTap != null) ...[
              Icon(
                FontAwesomeIcons.chevronRight,
                size: 16,
                color: theme.colorScheme.onSurface.withOpacity(0.3),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
