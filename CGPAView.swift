//
//  CGPAView.swift
//  GPA Calculator
//
//  Created by Furkan Akal on 25.02.2023.
//

import SwiftUI

struct CGPAView: View {
	@State var semesters: [Class3] = []
	@State var enteredSemesterCredit: Int = 0
	@State var enteredSemesterGPA: Double = 0.0
	@State var cGPA: Double = 0.0
	@State var selectedSemesterNo: Int = 0
	
	let semesterNos: [Int] = [1, 2, 3, 4, 5, 6, 7, 8]
	
	var body: some View {
		NavigationView {
			VStack {
				List {
					ForEach(semesters) { classItem in
						HStack {
							Text("Semester: \(classItem.semesterNo)")
								.font(.title3)
							Spacer()
							Text("Total Credit: \(classItem.semesterCredit)")
							Spacer()
							Text("Semester GPA: \(classItem.semesterGPA)")
						}
						.swipeActions(edge: .trailing, allowsFullSwipe: false) {
							Button(action: {
								self.semesters.removeAll(where: { $0.id == classItem.id })
								self.cGPA = calculateCGPA(semesters: self.semesters)
							}) {
								Label("Remove", systemImage: "trash")
							}
							.tint(.red)
						}
					}
					.onDelete(perform: { indexSet in
						self.semesters.remove(atOffsets: indexSet)
						self.cGPA = calculateCGPA(semesters: self.semesters)
					})
				}
				HStack {
					Picker("Semester No", selection: $selectedSemesterNo) {
						ForEach(semesterNos, id: \.self) { semesterNo in
							Text("\(semesterNo)").tag(semesterNo)
						}
					}
					.pickerStyle(MenuPickerStyle())
					TextField("Semester GPA", text: Binding(
							get: { String(format: "%.2f", enteredSemesterGPA) },
							set: { enteredSemesterGPA = Double($0) ?? 0.0 }
					))
					TextField("Semester Credit", text: Binding(
							get: { String(format: "%.2f", enteredSemesterCredit) },
							set: { enteredSemesterCredit = Int($0) ?? 0 }
					))
					Button(action: {
						guard !enteredSemesterGPA.description.isEmpty else {
							return
						}
						
						self.semesters.append(Class3(id: UUID(), semesterNo: self.selectedSemesterNo, semesterCredit: self.enteredSemesterCredit, semesterGPA: self.enteredSemesterGPA))
						self.selectedSemesterNo = 0
						self.enteredSemesterCredit = 0
						self.enteredSemesterGPA = 0.0
						
					}) {
						Text("Add")
					}
				}
				.padding()
				
				Button(action: {
					self.cGPA = calculateCGPA(semesters: self.semesters)
				}) {
					Text("Calculate cGPA")
						.font(.title3)
						.foregroundColor(.white)
				}
				.padding()
				.background(Color.blue)
				.cornerRadius(10)
				.padding()
			}
		}
	}
}

func calculateCGPA(semesters: [Class3]) -> Double {
	var totalCredits: Double = 0.0
	var totalGradePoints: Double = 0.0
	
	for classItem in semesters {
		totalCredits += Double(classItem.semesterCredit)
		totalGradePoints += Double(classItem.semesterCredit) * classItem.semesterGPA
	}
	
	return totalGradePoints / totalCredits
}

struct Class3: Identifiable {
	var id: UUID
	var semesterNo: Int
	var semesterCredit: Int
	var semesterGPA: Double
}

struct CGPAView_Previews: PreviewProvider {
	static var previews: some View {
		CGPAView()
	}
}
