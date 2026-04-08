import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/providers/todos_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todosProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("프로필")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(radius: 50, child: Icon(Icons.person, size: 50)),
            const SizedBox(height: 16),
            const Text(
              "사용자",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text("user@gmail.com"),
            const SizedBox(height: 32),
            const Text(
              "사용 통계",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildStatItem(context, "총 할 일 수", todos.length.toString()),
            _buildStatItem(
              context,
              "완료한 할 일 수",
              todos.where((todo) => todo.isCompleted).length.toString(),
            ),
            const SizedBox(height: 32),
            const Text(
              "설정",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildSettingItem(
              context,
              Icons.notifications,
              "알림 설정",
              () => _showNotImplementedSnackBar(context),
            ),
            _buildSettingItem(
              context,
              Icons.language,
              "언어 설정",
              () => _showNotImplementedSnackBar(context),
            ),
            _buildSettingItem(
              context,
              Icons.info,
              "앱 정보",
              () => _showNotImplementedSnackBar(context),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildStatItem(BuildContext context, String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    ),
  );
}

Widget _buildSettingItem(
  BuildContext context,
  IconData icon,
  String label,
  VoidCallback onTab,
) {
  return ListTile(
    leading: Icon(icon),
    title: Text(label),
    trailing: const Icon(Icons.chevron_right),
    onTap: onTab,
  );
}

void _showNotImplementedSnackBar(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text("이 기능은 아직 구현되지 않았습니다."),
      duration: Duration(seconds: 2),
    ),
  );
}
