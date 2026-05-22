import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/project_model.dart';
import '../repositories/project_repository.dart';

final projectRepositoryProvider = Provider((ref) {
  return ProjectRepository();
});

final projectsProvider = FutureProvider<List<ProjectModel>>((ref) async {
  final repo = ref.watch(projectRepositoryProvider);
  return repo.getProjects();
});