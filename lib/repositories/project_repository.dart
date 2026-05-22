import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/project_model.dart';

class ProjectRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<ProjectModel>> getProjects() async {
    final snapshot = await _firestore.collection('projects').get();

    return snapshot.docs
        .map((doc) => ProjectModel.fromJson(doc.data()))
        .toList();
  }

  Future<void> createProject(ProjectModel project) async {
    await _firestore
        .collection('projects')
        .doc(project.id)
        .set(project.toJson());
  }
}