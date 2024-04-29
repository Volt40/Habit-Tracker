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
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.red)
                .padding(.bottom, 20)
            HabitTableViewController(habitModel: HabitModel())
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
