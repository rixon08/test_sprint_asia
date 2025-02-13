import 'dart:io';

List<int> gradingStudents(List<int> grades) {
  return grades.map((grade) {
    if (grade < 38) return grade;
    int nextMultiple = ((grade / 5).ceil()) * 5;
    return (nextMultiple - grade < 3) ? nextMultiple : grade;
  }).toList();
}

void main() {
  print("Input");
  int n = checkNumberStudentInput();
  List<int> grades = [];

  for (int i = 0; i < n; i++) {
    grades.add(checkGradeInput());
  }

  print("Output");
  List<int> result = gradingStudents(grades);
  for (int i = 0; i < n; i++) {
    print("${result[i]}");
  }
  
}

int checkNumberStudentInput(){
  bool isSuccessInput = false;
  int numberStudent = 0;
  while(!isSuccessInput) {
    int input = int.parse(stdin.readLineSync()!);
    if (input >= 1 && input <= 60) {
      isSuccessInput = true;
      numberStudent = input;
    } else {
      print("Number must be 1 <= n <= 60");
    }
  }
  return numberStudent;
}

int checkGradeInput(){
  bool isSuccessInput = false;
  int grade = 0;
  while(!isSuccessInput) {
    int input = int.parse(stdin.readLineSync()!);
    if (input >= 0 && input <= 100) {
      isSuccessInput = true;
      grade = input;
    } else {
      print("Number must be 0 <= n <= 100");
    }
  }
  return grade;
}
