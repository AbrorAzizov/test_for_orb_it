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

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settings)),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          return ListView(
            children: [
              ListTile(
                title: Text(l10n.theme),
                trailing: DropdownButton<ThemeMode>(
                  value: state.themeMode,
                  onChanged: (ThemeMode? mode) {
                    if (mode != null) {
                      context.read<SettingsBloc>().add(ThemeChanged(mode));
                    }
                  },
                  items: [
                    DropdownMenuItem(value: ThemeMode.system, child: Text(l10n.system)),
                    DropdownMenuItem(value: ThemeMode.light, child: Text(l10n.light)),
                    DropdownMenuItem(value: ThemeMode.dark, child: Text(l10n.dark)),
                  ],
                ),
              ),
              ListTile(
                title: Text(l10n.language),
                trailing: DropdownButton<Locale>(
                  value: state.locale,
                  onChanged: (Locale? locale) {
                    if (locale != null) {
                      context.read<SettingsBloc>().add(LanguageChanged(locale));
                    }
                  },
                  items: [
                    DropdownMenuItem(value: const Locale('en'), child: Text(l10n.english)),
                    DropdownMenuItem(value: const Locale('ru'), child: Text(l10n.russian)),
                  ],
                ),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: Text(l10n.logout, style: const TextStyle(color: Colors.red)),
                onTap: () {
                  context.read<AuthBloc>().add(LogoutRequested());
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
