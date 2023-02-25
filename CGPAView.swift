//
//  CGPAView.swift
//  GPA Calculator
//
//  Created by Furkan Akal on 25.02.2023.
//

import SwiftUI

struct CGPAView: View {
	@State var classes: [Class3] = []
	
	
	var body: some View {
		NavigationView {
			
		}
	}
}

func calculateCGPA(classes: [Class3]) -> Double {
	var
}

struct Class3: Identifiable {
	var id: UUID
	var name: String
	var gpa: Double
}

struct CGPAView_Previews: PreviewProvider {
	static var previews: some View {
		CGPAView()
	}
}
