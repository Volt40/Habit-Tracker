//
//  HabitTableViewController.swift
//  FinalProject
//
//  Created by Michael Baljet on 4/28/24.
//

import SwiftUI

struct HabitTableViewController: View {
    
    @State public static var habits: [Habit] = []
    
    var body: some View {
        List {
            ForEach(HabitTableViewController.habits, id: \.name) { habit in
                HabitRowView(habit: habit)
            }
        }
    }
}

struct HabitRowView: View {
    let habit: Habit
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Name: \(habit.name)")
            Text("Days: \(habit.daysDescription)")
        }
        .padding()
    }
}

extension Habit {
    var daysDescription: String {
        let daysOfWeek = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
        let selectedDays = zip(daysOfWeek, days).filter { $0.1 }.map { $0.0 }
        return selectedDays.isEmpty ? "None" : selectedDays.joined(separator: ", ")
    }
}

#Preview {
    HabitTableViewController()
}
