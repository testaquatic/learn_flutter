class Student {
  final String name;
  final int age;
  final Map<String, int> scores;

  Student(this.name, this.age, this.scores);
}

void main() {
  final students = [
    Student('홍길동', 20, {'수학': 90, '영어': 85, '과학': 95}),
    Student('김철수', 22, {'수학': 75, '영어': 90, '과학': 85}),
    Student('이영희', 21, {'수학': 85, '영어': 92, '과학': 88}),
    Student('박민수', 23, {'수학': 95, '영어': 80, '과학': 92}),
  ];

  final averageScores = students.map((student) {
    final total = student.scores.values.fold<int>(
      0,
      (sum, score) => sum + score,
    );
    final average = total / student.scores.length;
    return {"name": student.name, "average": average};
  }).toList();

  print("평균 점수");
  for (final item in averageScores) {
    print("${item['name']}: ${item['average']}");
  }

  final highPerformers = students
      .where((student) {
        final total = student.scores.values.fold(
          0,
          (sum, score) => sum + score,
        );
        final average = total / student.scores.length;
        return average >= 90;
      })
      .map((student) {
        return student.name;
      })
      .toList();

  print("\n우수 학생: $highPerformers");

  final subjects = ["수학", "영어", "과학"];

  final topScoresBySubject = subjects.fold<Map<String, Map<String, dynamic>>>(
    {},
    (map, subject) {
      var topStudent = students.reduce(
        (a, b) => (a.scores[subject] ?? 0) > (b.scores[subject] ?? 0) ? a : b,
      );
      map[subject] = {
        "student": topStudent.name,
        "score": topStudent.scores[subject],
      };
      return map;
    },
  );

  print("\n과목별 최고 점수:");
  topScoresBySubject.forEach((subject, data) {
    print("$subject: ${data["student"]} (${data["score"]}점)");
  });
}
