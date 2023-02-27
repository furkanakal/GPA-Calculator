//
//  ContentView.swift
//  GPA Calculator
//
//  Created by Furkan Akal on 23.02.2023.
//

import SwiftUI

struct ContentView: View {
	@State var isVisible = false
	
	@State var classes: [Class] = []
	@State var selectedCredit: Int = 0
	@State var selectedGrade: String = "AA"
	@State var gpa: Double = 0.0
	@State var className: String = ""
	
	let credits: [Int] = [2, 3, 4, 5]
	let grades: [String] = ["AA", "BA", "BB", "CB", "CC", "DC", "DD", "FD", "FF"]
	
	var body: some View {
		NavigationView {
			VStack {
				List {
					ForEach(classes) { classItem in
						HStack {
							Text(classItem.name)
								.font(.title3)
							Spacer()
							Text("Credit: \(classItem.credit)")
							Spacer()
							Text("Grade: \(classItem.grade)")
						}
						.swipeActions(edge: .trailing, allowsFullSwipe: false) {
							Button(action: {
								self.classes.removeAll(where: { $0.id == classItem.id })
								self.gpa = calculateGPA(classes: self.classes)
							}) {
								Label("Remove", systemImage: "trash")
							}
							.tint(.red)
						}
					}
					.onDelete(perform: { indexSet in
						self.classes.remove(atOffsets: indexSet)
						self.gpa = calculateGPA(classes: self.classes)
					})
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
						guard !className.isEmpty else {
							return
						}
						
						self.classes.append(Class(id: UUID(), name: self.className, credit: self.selectedCredit, grade: self.selectedGrade))
						self.className = ""
						self.selectedCredit = 2
						self.selectedGrade = "AA"
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
			.opacity(isVisible ? 1.0 : 0.0)
			.animation(.easeInOut(duration: 1.0))
			.onAppear {
				self.isVisible = true
			}
			.navigationTitle("GPA Calculator")
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
		case "AA":
			totalGradePoints += 4.0 * Double(classItem.credit)
		case "BA":
			totalGradePoints += 3.5 * Double(classItem.credit)
		case "BB":
			totalGradePoints += 3.0 * Double(classItem.credit)
		case "CB":
			totalGradePoints += 2.5 * Double(classItem.credit)
		case "CC":
			totalGradePoints += 2.0 * Double(classItem.credit)
		case "DC":
			totalGradePoints += 1.5 * Double(classItem.credit)
		case "DD":
			totalGradePoints += 1.0 * Double(classItem.credit)
		case "FD":
			totalGradePoints += 0.5 * Double(classItem.credit)
		case "FF":
			totalGradePoints += 0.0 * Double(classItem.credit)
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
			.preferredColorScheme(.dark)
	}
}
