//
//  TaskViewModel.swift
//  Task Management App
//
//  Created by Aleksa Dimitrijevic on 13.6.22..
//

import SwiftUI

class TaskViewModel: ObservableObject{
    
    
    @Published var storedTasks: [Task] = [
    
        Task(taskTitle: "Zavrsi projekat", taskDescription: "Sredi dizajn i funkcionalnosti na samom projektu", taskDate: .init(timeIntervalSince1970: 1641645487)),
        Task(taskTitle: "Nauci osnove kvaliteta za ispit", taskDescription: "Vidi gradivo koje je potrebno da spremis", taskDate: .init(timeIntervalSince1970: 1641645487)),
        Task(taskTitle: "Pregledaj dizajn aplikacije", taskDescription: "Dodatno prepravi ako se nesto ne uklapa", taskDate: .init(timeIntervalSince1970: 1641645487)),
        Task(taskTitle: "Prijavi temu diplomskog rada", taskDescription: "U studentskoj sluzbi prijavi i sacekaj proceduru", taskDate: .init(timeIntervalSince1970: 1641645487)),
        Task(taskTitle: "Zavrsi igricu u Unity okruzenju", taskDescription: "Dodaj funkcionalnosti za glavnog junaka", taskDate: .init(timeIntervalSince1970: 1641645487)),
        Task(taskTitle: "Trening", taskDescription: "Ruke i ramena", taskDate: .init(timeIntervalSince1970: 1641645487)),
    
    
    
    
    
    ]
}
