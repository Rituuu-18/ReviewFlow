import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reviewflow/models/project_model.dart';
import 'package:reviewflow/providers/project_provider.dart';
import 'package:reviewflow/providers/theme_provider.dart';
import 'package:reviewflow/repositories/project_repository.dart';

class FakeProjectRepository extends ProjectRepository {
  @override
  Future<List<ProjectModel>> getProjects() async {
    return [
      ProjectModel(
        id: 'p1',
        name: 'Project One',
        description: 'First project',
        status: 'active',
        dueDate: DateTime(2026, 12, 31),
      ),
    ];
  }
}

void main() {
  test('State management: theme toggles correctly', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    expect(container.read(themeProvider), ThemeMode.light);
    container.read(themeProvider.notifier).toggleTheme();
    expect(container.read(themeProvider), ThemeMode.dark);
  });

  test('API/service calls: projectsProvider resolves repository data', () async {
    final container = ProviderContainer(
      overrides: [
        projectRepositoryProvider.overrideWithValue(FakeProjectRepository()),
      ],
    );
    addTearDown(container.dispose);

    final projects = await container.read(projectsProvider.future);

    expect(projects, isNotEmpty);
    expect(projects.first.id, 'p1');
    expect(projects.first.name, 'Project One');
  });
}
