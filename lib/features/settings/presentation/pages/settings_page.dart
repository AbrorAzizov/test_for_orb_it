import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_for_orb_it/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:test_for_orb_it/features/auth/presentation/bloc/auth_event.dart';
import 'package:test_for_orb_it/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:test_for_orb_it/features/settings/presentation/bloc/settings_event.dart';
import 'package:test_for_orb_it/features/settings/presentation/bloc/settings_state.dart';

import '../../../../l10n/app_localizations.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surfaceVariant.withOpacity(0.3),
      body: SafeArea(
        child: BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.settings,
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    l10n.settingsSubtitle,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Card(
                    elevation: 0,
                    color: theme.colorScheme.surface,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(color: theme.colorScheme.outlineVariant),
                    ),
                    child: Column(
                      children: [
                        _SettingsTile(
                          icon: Icons.monitor,
                          iconColor: Colors.blue,
                          title: l10n.theme,
                          subtitle: l10n.themeSubtitle,
                          trailing: _DropdownWrapper(
                            child: DropdownButton<ThemeMode>(
                              value: state.themeMode,
                              isExpanded: true,
                              underline: const SizedBox(),
                              icon: const Icon(Icons.keyboard_arrow_down, size: 20),
                              items: [
                                DropdownMenuItem(value: ThemeMode.system, child: Text(l10n.system)),
                                DropdownMenuItem(value: ThemeMode.light, child: Text(l10n.light)),
                                DropdownMenuItem(value: ThemeMode.dark, child: Text(l10n.dark)),
                              ],
                              onChanged: (mode) {
                                if (mode != null) {
                                  context.read<SettingsBloc>().add(ThemeChanged(mode));
                                }
                              },
                            ),
                          ),
                        ),
                        Divider(height: 1, indent: 64, endIndent: 16, color: theme.colorScheme.outlineVariant),
                        _SettingsTile(
                          icon: Icons.language,
                          iconColor: Colors.blue,
                          title: l10n.language,
                          subtitle: l10n.languageSubtitle,
                          trailing: _DropdownWrapper(
                            child: DropdownButton<Locale>(
                              value: state.locale,
                              isExpanded: true,
                              underline: const SizedBox(),
                              icon: const Icon(Icons.keyboard_arrow_down, size: 20),
                              items: [
                                DropdownMenuItem(value: const Locale('en'), child: Text(l10n.english)),
                                DropdownMenuItem(value: const Locale('ru'), child: Text(l10n.russian)),
                              ],
                              onChanged: (locale) {
                                if (locale != null) {
                                  context.read<SettingsBloc>().add(LanguageChanged(locale));
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Card(
                    elevation: 0,
                    color: theme.colorScheme.surface,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(color: theme.colorScheme.outlineVariant),
                    ),
                    child: _SettingsTile(
                      icon: Icons.logout,
                      iconColor: Colors.red,
                      title: l10n.logout,
                      titleColor: Colors.red,
                      subtitle: l10n.logoutSubtitle,
                      trailing: const Icon(Icons.chevron_right, color: Colors.red, size: 20),
                      onTap: () {
                        context.read<AuthBloc>().add(LogoutRequested());
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _DropdownWrapper extends StatelessWidget {
  final Widget child;

  const _DropdownWrapper({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Theme.of(context).colorScheme.outlineVariant,
        ),
      ),
      child: child,
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final Widget trailing;
  final VoidCallback? onTap;
  final Color? titleColor;

  const _SettingsTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.trailing,
    this.onTap,
    this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconColor, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: titleColor ?? theme.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            trailing,
          ],
        ),
      ),
    );
  }
}
