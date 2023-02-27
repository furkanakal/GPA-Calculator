//
//  MainView.swift
//  GPA Calculator
//
//  Created by Furkan Akal on 25.02.2023.
//

import SwiftUI

struct MainView: View {	
	var body: some View {
		TabView {
			ContentView()
				.tabItem {
					Label("GPA 1", systemImage: "list.dash")
				}
			
			ContentView2()
				.tabItem {
					Label("GPA 2", systemImage: "list.dash")
				}
			
			Spacer()
			
			CGPAView()
				.tabItem {
					Label("cGPA", systemImage: "graduationcap.fill")
				}
		}
	}
}

struct MainView_Previews: PreviewProvider {
	static var previews: some View {
		MainView()
			.preferredColorScheme(.dark)
	}
}
