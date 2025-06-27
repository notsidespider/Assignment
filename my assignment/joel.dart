import 'dart:io';

void main() {
  // Welcome message
  print('UENR Student Grade Calculator');
  print('Developed for Dr. Kwame Asante\n');

  // Get the number of students
  stdout.write('Enter the number of students: ');
  int numberOfStudents = int.parse(stdin.readLineSync()!);

  // List to store student records
  List<Map<String, dynamic>> studentRecords = [];

  // Input loop for each student
  for (int i = 0; i < numberOfStudents; i++) {
    print('\nEnter details for Student ${i + 1}:');
    
    // Get student name
    stdout.write('Student Name: ');
    String name = stdin.readLineSync()!;
    
    // Get continuous assessment score (out of 30)
    double caScore = getValidScore('Continuous Assessment (out of 30): ', 30);
    
    // Get exam score (out of 50)
    double examScore = getValidScore('Exam Score (out of 50): ', 50);
    
    // Get project score (out of 20)
    double projectScore = getValidScore('Project Score (out of 20): ', 20);

    // Calculate total score (converted to percentage)
    double totalScore = (caScore + examScore + projectScore) * 100 / 100;
    
    // Determine letter grade
    String grade = calculateGrade(totalScore);

    // Store student record
    studentRecords.add({
      'name': name,
      'caScore': caScore,
      'examScore': examScore,
      'projectScore': projectScore,
      'totalScore': totalScore,
      'grade': grade,
    });
  }

  // Display all student records
  print('\n\n=== Grading Results ===');
  for (var student in studentRecords) {
    print('\nStudent: ${student['name']}');
    print('CA: ${student['caScore']}/30');
    print('Exam: ${student['examScore']}/50');
    print('Project: ${student['projectScore']}/20');
    print('Total: ${student['totalScore'].toStringAsFixed(2)}%');
    print('Grade: ${student['grade']}');
  }

  // Export option
  stdout.write('\nWould you like to export these results to a file? (y/n): ');
  String exportChoice = stdin.readLineSync()!.toLowerCase();
  if (exportChoice == 'y') {
    exportToFile(studentRecords);
  }

  print('\nGrading complete. Thank you for using the UENR Grade Calculator!');
}

// Helper function to get valid scores within range
double getValidScore(String prompt, int maxScore) {
  double score;
  while (true) {
    stdout.write(prompt);
    score = double.parse(stdin.readLineSync()!);
    if (score >= 0 && score <= maxScore) {
      return score;
    }
    print('Error: Score must be between 0 and $maxScore. Please try again.');
  }
}

// Function to calculate letter grade based on total score
String calculateGrade(double totalScore) {
  if (totalScore >= 80) return 'A';
  if (totalScore >= 75) return 'B+';
  if (totalScore >= 70) return 'B';
  if (totalScore >= 65) return 'C+';
  if (totalScore >= 60) return 'C';
  if (totalScore >= 55) return 'D+';
  if (totalScore >= 50) return 'D';
  if (totalScore >= 45) return 'E';
  return 'F';
}

// Function to export results to a text file
void exportToFile(List<Map<String, dynamic>> records) {
  final timestamp = DateTime.now().toString().replaceAll(RegExp(r'[^\w-]'), '_');
  final filename = 'uenr_grades_$timestamp.txt';
  final file = File(filename);
  
  String output = 'UENR Grade Report - ${DateTime.now()}\n\n';
  for (var student in records) {
    output += '''
Student: ${student['name']}
CA: ${student['caScore']}/30
Exam: ${student['examScore']}/50
Project: ${student['projectScore']}/20
Total: ${student['totalScore'].toStringAsFixed(2)}%
Grade: ${student['grade']}
-------------------------
''';
  }
  
  file.writeAsStringSync(output);
  print('Results exported to $filename');
}