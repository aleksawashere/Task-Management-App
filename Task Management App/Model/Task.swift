//
//  Task.swift
//  Task Management App
//
//  Created by Aleksa Dimitrijevic on 13.6.22..
//

import SwiftUI

//Task model

struct Task: Identifiable{
    var id = UUID().uuidString
    var taskTitle: String
    var taskDescription: String
    var taskDate: Date
}
