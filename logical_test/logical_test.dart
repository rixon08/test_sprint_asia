import 'dart:io';

List<int> gradingStudents(List<int> grades) {
  return grades.map((grade) {
    if (grade < 38) return grade;
    int nextMultiple = ((grade / 5).ceil()) * 5;
    return (nextMultiple - grade < 3) ? nextMultiple : grade;
  }).toList();
}

void main() {
  // Masukkan jumlah siswa
  print("Input");
  int n = int.parse(stdin.readLineSync()!);
  List<int> grades = [];

  // Masukkan nilai siswa
  for (int i = 0; i < n; i++) {
    grades.add(int.parse(stdin.readLineSync()!));
  }

  print("Output");
  List<int> result = gradingStudents(grades);
  for (int i = 0; i < n; i++) {
    print("${result[i]}");
  }
  
}
