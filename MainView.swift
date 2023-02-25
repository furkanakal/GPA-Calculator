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
					Label("Mode 1", systemImage: "list.dash")
				}
			
			ContentView2()
				.tabItem {
					Label("Mode 2", systemImage: "list.dash")
				}
			
			CGPAView()
				.tabItem {
					Label("cGPA", systemImage: "list.dash")
				}
		}
	}
}

struct MainView_Previews: PreviewProvider {
	static var previews: some View {
		MainView()
	}
}
