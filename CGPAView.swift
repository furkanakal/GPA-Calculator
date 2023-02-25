//
//  CGPAView.swift
//  GPA Calculator
//
//  Created by Furkan Akal on 25.02.2023.
//

import SwiftUI

struct CGPAView: View {
	@State var semesters: [Class3] = []
	@State var semesterCredit: Double = 0.0
	@State var semesterGPA: Double = 0.0
	@State var cGPA: Double = 0.0
	@State var semesterNo: Int = 0
	
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
				}
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
