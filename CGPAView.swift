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
	@State var selectedSemesterNo: Int = 1
	
	@State private var enteredSemesterCreditText = ""
	@State private var enteredSemesterGPAText = ""
	
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
							Text("GPA: \(String(format: "%.2f", classItem.semesterGPA))")
						}
						.swipeActions(edge: .trailing, allowsFullSwipe: true) {
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
				
				Section(header:
					HStack {
						Text("PLEASE ENTER THE CREDIT AMOUNT AND THE GPA.")
							.lineLimit(1)
							.font(.caption)
							.foregroundColor(.white)
							.padding(.all)
							.frame(maxWidth: .infinity, alignment: .center)
							.background(Color(.systemGray6))
					}
				) {
					HStack {
						Picker("Semester No", selection: $selectedSemesterNo) {
							ForEach(semesterNos, id: \.self) { semesterNo in
								Text("\(semesterNo)").tag(semesterNo)
							}
						}
						.pickerStyle(MenuPickerStyle())
						TextEditor(text: $enteredSemesterCreditText)
							.frame(width: 80, height: 35)
							.border(Color.gray.opacity(0.5), width: 1)
							.padding(.leading, 5)
							.foregroundColor(Color(.systemGray))
							.opacity(enteredSemesterCredit == 0 ? 0.5 : 1.0)
							.overlay(
								Text("Credit")
									.foregroundColor(Color(.systemGray3))
									.opacity(enteredSemesterCredit == 0 ? 1.0 : 0.0)
									.padding()
							)
							.onChange(of: enteredSemesterCreditText) { newValue in
								// Update the binding to an Int whenever the text changes
									enteredSemesterCredit = Int(newValue) ?? 0
							}
						
						TextEditor(text: $enteredSemesterGPAText)
							.frame(width: 80, height: 35)
							.border(Color.gray.opacity(0.5), width: 1)
							.padding(.leading, 5)
							.foregroundColor(Color(.systemGray))
							.opacity(enteredSemesterGPA == 0 ? 0.5 : 1.0)
							.overlay(
								Text("GPA")
									.foregroundColor(Color(.systemGray3))
									.opacity(enteredSemesterGPA == 0 ? 1.0 : 0.0)
									.padding()
							)
							.onChange(of: enteredSemesterGPAText) { newValue in
								// Update the binding to a Double whenever the text changes
								enteredSemesterGPA = Double(newValue) ?? 0.0
							}
						
						Button(action: {
							guard !enteredSemesterGPA.description.isEmpty else {
								return
							}
							
							self.semesters.append(Class3(id: UUID(), semesterNo: self.selectedSemesterNo, semesterCredit: self.enteredSemesterCredit, semesterGPA: self.enteredSemesterGPA))
							self.selectedSemesterNo = 1
							self.enteredSemesterCredit = 0
							self.enteredSemesterGPA = 0.0
							self.enteredSemesterCreditText = ""
							self.enteredSemesterGPAText = ""
							
						}) {
							Text("Add")
						}
					}
					.padding()
				}
				
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
					
				Text("cGPA: \(String(format: "%.2f", self.cGPA))")
					.font(.title)
					.fontWeight(.bold)
			}
			.navigationTitle("cGPA Calculator")
			.padding()
		}
		.onTapGesture {
			hideKeyboard3()
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

extension View {
	func hideKeyboard3() {
		let resign = #selector(UIResponder.resignFirstResponder)
		UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
	}
}

struct CGPAView_Previews: PreviewProvider {
	static var previews: some View {
		CGPAView()
			.preferredColorScheme(.dark)
	}
}
