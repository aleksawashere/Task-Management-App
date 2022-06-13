//
//  NewTask.swift
//  Task Management App
//
//  Created by Aleksa Dimitrijevic on 14.6.22..
//

import SwiftUI

struct NewTask: View {
    @Environment(\.dismiss) var dismiss
    
    //MARK: Task Values
    @State var taskTitle: String = ""
    @State var taskDescription: String = ""
    @State var taskDate: Date = Date()
    
    //MARK: Core Data Context
    @Environment(\.managedObjectContext) var context
    

    var body: some View {

        NavigationView{
            List{
                Section{
                    TextField("Go to work", text: $taskTitle)
                } header: {
                    Text("Task Title")
                }
                
                Section{
                    TextField("Nothing else to say.", text: $taskDescription)
                } header: {
                    Text("Task Description")
                }
                
                Section{
                    DatePicker("", selection: $taskDate)
                        .datePickerStyle(.graphical)
                        .labelsHidden()
                } header: {
                    Text("Task Date")
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Add New Task")
            .navigationBarTitleDisplayMode(.inline)
            //MARK: Disabling Dismiss on Swipe
            .interactiveDismissDisabled()
            //MARK: Action Buttons
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing){
                    Button("Sačuvaj"){
                        let task = Task(context: context)//komunikacija sa objektom u CoreData
                        task.taskTitle = taskTitle
                        task.taskDescription = taskDescription
                        task.taskDate = taskDate
                        
                        //Cuvanje podataka
                        
                        try? context.save()
                        
                        //Gasenje prozora
                        dismiss()
                    }
                    .disabled(taskTitle == "" || taskDescription == "")
                }
                
                ToolbarItem(placement: .navigationBarLeading){
                    Button("Odustani"){
                        dismiss()
                    }
                }
            }
        }

    }
}
