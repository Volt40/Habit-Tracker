//
//  HabitTableViewController.swift
//  FinalProject
//
//  Created by Michael Baljet on 4/28/24.
//

import SwiftUI

class HabitModel: ObservableObject {
    @Published var habits: [Habit] = []
}

struct HabitTableViewController: View {
    
    @ObservedObject var habitModel: HabitModel
    
    var body: some View {
            NavigationView {
                VStack {
                    ForEach(habitModel.habits, id: \.name) { habit in
                        //Text(habit.name)
                        HabitRowView(habit: habit)
                    }
                    NavigationLink("New Habit to Track") {
                        NewHabitViewController(habitModel: habitModel, name: "name")
                    }
                }
                
            }.onAppear {
            // Load habits when the view appears
            loadHabits()
        }
    }
    
    func loadHabits() {
            // For demonstration purposes, let's add some dummy habits
            habitModel.habits = [
                Habit(name: "Exercise", days: [true, true, true, true, true, false, false]),
                Habit(name: "Reading", days: [false, false, true, true, false, true, false])
            ]
        }
}

struct HabitRowView: View {
    let habit: Habit
    let daysOfWeek = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]

    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(habit.name)
                .font(.headline)
                .padding(.bottom, 4)
            
            HStack(spacing: 20) {
                ForEach(Array(habit.days.enumerated()), id: \.offset) { index, day in
                    if (habit.days[index]) {
                        DayOfWeekVToggle(dayIndex: index, isSelected: Binding(
                            get: { habit.days[index] },
                            set: { newValue in
                                var updatedDays = habit.days
                                updatedDays[index] = newValue
                            }
                        ))
                    }
                    
                }
            }
        }
        .padding()
    }
}


struct DayOfWeekVToggle: View {
    let dayIndex: Int
    @Binding var isSelected: Bool
    let daysOfWeek = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    
    var body: some View {
        VStack {
            Text(daysOfWeek[dayIndex].prefix(3)) // Display only the first 3 characters of the day name
            
            Button(action: {
                isSelected.toggle()
            }) {
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.primary, lineWidth: 2)
                    .frame(width: 20, height: 20)
                    .foregroundColor(isSelected ? Color.primary : Color.clear)
            }
            .buttonStyle(PlainButtonStyle())
        }
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
    HabitTableViewController(habitModel: HabitModel())
}
