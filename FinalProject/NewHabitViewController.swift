//
//  NewHabitViewController.swift
//  FinalProject
//
//  Created by Michael Baljet on 4/28/24.
//

import SwiftUI

struct DayOfWeekToggle: View {
    @Binding var selectedDays: [Bool]
    let dayIndex: Int
    let dayName: String
    
    var body: some View {
        Toggle(isOn: $selectedDays[dayIndex]) {
            Text(dayName)
        }
    }
}

struct NewHabitViewController: View {
    
    @ObservedObject var habitModel: HabitModel
    @State var name : String;
    @State private var selectedDays = Array(repeating: false, count: 7)
    @State private var showingPopup = false
    let daysOfWeek = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]

    func saveHabit() {
        let newHabit = Habit(name: name, days: selectedDays)
                habitModel.habits.append(newHabit)
        showingPopup = true
    }
    
    var body: some View {
        VStack {
            Text("Create new Habit")
            HStack {
                Spacer()
                Text("Name: ")
                TextField("habit name", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Spacer()
            }
            Text("Days")
            VStack {
                ForEach(0..<7) { index in
                    DayOfWeekToggle(selectedDays: $selectedDays, dayIndex: index, dayName: daysOfWeek[index])
                }
            }
            Button("Save") {
                saveHabit()
            }
        }
        .alert(isPresented: $showingPopup) {
            Alert(
                title: Text("Habit Manager"),
                message: Text("Habit Saved Successfully!"),
                primaryButton: .default(Text("OK")),
                secondaryButton: .cancel()
            )
        }
    }
    
}


