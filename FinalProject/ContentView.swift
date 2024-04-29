//
//  ContentView.swift
//  FinalProject
//
//  Created by Michael Baljet on 4/28/24.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        VStack {
            Text("Habits Tracker")
            NavigationView {
                VStack {
                    HabitTableViewController()
                    NavigationLink("Add Habit to Track") {
                        NewHabitViewController(name: "Habit 1")
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
