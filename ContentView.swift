//
//  ContentView.swift
//  GPA Calculator
//
//  Created by Furkan Akal on 23.02.2023.
//

import SwiftUI

struct ContentView: View {
	@State var classes: [Class] = []
	@State var selectedCredit: Int = 0
	@State var selectedGrade: String = "A"
	@State var gpa: Double = 0.0
	@State var className: String = ""
		
	let credits: [Int] = [1, 2, 3, 4, 5]
	let grades: [String] = ["A", "B+", "B", "C+", "C", "D+", "D", "F"]
		
	var body: some View {
		NavigationView {
			VStack {
				List(classes, id: \.id) { classItem in
					Text(classItem.name)
						.font(.title3)
					HStack {
						Text("Credit: \(classItem.credit)")
						Spacer()
						Text("Grade: \(classItem.grade)")
					}
				}
				HStack {
					TextField("Enter class name", text: $className)
					Picker("Credit", selection: $selectedCredit) {
						ForEach(credits, id: \.self) { credit in
							Text("\(credit)").tag(credit)
						}
					}
					.pickerStyle(MenuPickerStyle())
					Picker("Grade", selection: $selectedGrade) {
						ForEach(grades, id: \.self) { grade in
							Text("\(grade)").tag(grade)
						}
					}
					.pickerStyle(MenuPickerStyle())
					Button(action: {
						self.classes.append(Class(id: UUID(), name: self.className, credit: self.selectedCredit, grade: self.selectedGrade))
						self.className = ""
						self.selectedCredit = 0
						self.selectedGrade = "A"
					}) {
						Text("Add")
					}
				}
				.padding()
				Button(action: {
					self.gpa = calculateGPA(classes: self.classes)
				}) {
					Text("Calculate GPA")
						.font(.title3)
						.foregroundColor(.white)
				}
				.padding()
				.background(Color.blue)
				.cornerRadius(10)
				.padding()
				Text("GPA: \(String(format: "%.2f", self.gpa))")
					.font(.title)
					.fontWeight(.bold)
			}
			.padding()
		}
	}
}
		
func calculateGPA(classes: [Class]) -> Double {
	var totalCredits: Double = 0.0
	var totalGradePoints: Double = 0.0
	
	for classItem in classes {
		totalCredits += Double(classItem.credit)
		switch classItem.grade {
		case "A":
			totalGradePoints += 4.0 * Double(classItem.credit)
		case "B+":
			totalGradePoints += 3.5 * Double(classItem.credit)
		case "B":
			totalGradePoints += 3.0 * Double(classItem.credit)
		case "C+":
			totalGradePoints += 2.5 * Double(classItem.credit)
		case "C":
			totalGradePoints += 2.0 * Double(classItem.credit)
		case "D+":
			totalGradePoints += 1.5 * Double(classItem.credit)
		case "D":
			totalGradePoints += 1.0 * Double(classItem.credit)
		default:
			totalGradePoints += 0.0
		}
	}
	return totalGradePoints / totalCredits
}
		
struct Class: Identifiable {
	var id: UUID
	var name: String
	var credit: Int
	var grade: String
}


struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
