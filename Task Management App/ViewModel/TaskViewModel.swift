//
//  TaskViewModel.swift
//  Task Management App
//
//  Created by Aleksa Dimitrijevic on 13.6.22..
//

import SwiftUI

class TaskViewModel: ObservableObject{
    
    
    @Published var storedTasks: [Task] = [
    
        Task(taskTitle: "Zavrsi projekat", taskDescription: "Sredi dizajn i funkcionalnosti na samom projektu", taskDate: .init(timeIntervalSince1970: 1655155826)),
        Task(taskTitle: "Nauci osnove kvaliteta za ispit", taskDescription: "Vidi gradivo koje je potrebno da spremis", taskDate: .init(timeIntervalSince1970: 1655144826)),
        Task(taskTitle: "Pregledaj dizajn aplikacije", taskDescription: "Dodatno prepravi ako se nesto ne uklapa", taskDate: .init(timeIntervalSince1970: 1655200911)),
        Task(taskTitle: "Prijavi temu diplomskog rada", taskDescription: "U studentskoj sluzbi prijavi i sacekaj proceduru", taskDate: .init(timeIntervalSince1970: 1655200911)),
        Task(taskTitle: "Zavrsi igricu u Unity okruzenju", taskDescription: "Dodaj funkcionalnosti za glavnog junaka", taskDate: .init(timeIntervalSince1970: 1655200911)),
        Task(taskTitle: "Trening", taskDescription: "Ruke i ramena", taskDate: .init(timeIntervalSince1970: 1655200911))
    ]
    
    //MARK: Current Week Days
    
    @Published var currentWeek: [Date] = []
    
    //MARK: Current Day
    //Pamcenjem ove varijable, znacemo na kom danu se nalazimo kada korisnik klikne
    @Published var currentDay: Date = Date()
    
    //MARK: Filtering todays tasks
    
    @Published var filteredTasks: [Task]?
    
    //MARK: Initializing
    init(){
        fetchCurrentWeek()
        filterTodaysTasks()
    }
    
    //MARK: Filter Todays Tasks
    
    func filterTodaysTasks(){
        DispatchQueue.global(qos: .userInteractive).async {
            
            let calendar = Calendar.current
            
            let filtered = self.storedTasks.filter{
                return calendar.isDate($0.taskDate, inSameDayAs: self.currentDay)
            }
            
            DispatchQueue.main.async {
                withAnimation{
                    self.filteredTasks = filtered
                }
            }
        }
    }
    
    func fetchCurrentWeek(){
        let today = Date()
        let calendar = Calendar.current
        
        let week = calendar.dateInterval(of: .weekOfMonth, for: today)
        
        guard let firstWeekDay = week?.start else{
            return
        }
        
        (1...7).forEach { day in
           if let weekday = calendar.date(byAdding: .day, value: day, to: firstWeekDay){
                currentWeek.append(weekday)
            }
        }
    }
    
    //MARK: Extracting Date
    
    func extractDate(date: Date, format: String) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    
    //MARK: Checking if current Date is Today
    //Moramo proveriti svakog puta koji dan je Danas, kako bi se na taj element prvo "zakacili"
    
    func isToday(date: Date)->Bool{
        let calender = Calendar.current
        return calender.isDate(currentDay, inSameDayAs: date)
    }
    
    //MARK: Checking if the currentHour is task Hour
    func isCurrentHour(date: Date)->Bool{
        
        let calendar = Calendar.current
        
        let hour = calendar.component(.hour, from: date)
        let currentHour = calendar.component(.hour, from: Date())
        
        return hour == currentHour
    }
}
