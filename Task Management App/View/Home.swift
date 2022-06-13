//
//  Home.swift
//  Task Management App
//
//  Created by Aleksa Dimitrijevic on 13.6.22..
//

import SwiftUI

struct Home: View {
    @StateObject var taskModel: TaskViewModel = TaskViewModel()
    @Namespace var animation
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){

            //MARK: Lazy stack with pinned header
            LazyVStack(spacing:15, pinnedViews: [.sectionHeaders]) {
                
                
                Section{
                //MARK: Current Week View
                    ScrollView(.horizontal, showsIndicators: false){
                        
                        HStack(spacing:10){
                            ForEach(taskModel.currentWeek, id: \.self){ day in
                                
                                VStack(spacing:10){
                                    
                                    Text(taskModel.extractDate(date: day, format: "dd"))
                                        .font(.system(size:14))
                                        .fontWeight(.semibold)

                                    
                                    //EEE will return day in as MON, TUE,...
                                    Text(taskModel.extractDate(date: day, format: "EEE"))
                                        .font(.system(size:14))
                                    
                                    Circle()
                                        .fill(.white)
                                        .frame(width:8, height: 8)
                                        .opacity(taskModel.isToday(date: day) ? 1 : 0)
                                }
                                //MARK: Foreground Style
                                .foregroundStyle(taskModel.isToday(date: day) ? .primary : .secondary)
                                .foregroundColor(taskModel.isToday(date: day) ? .white : .black)
                                //MARK: Capsule shape
                                .frame(width: 45, height: 90)
                                .background(
                                
                                    ZStack{
                                        //MARK: Animation when we change weekday
                                        if taskModel.isToday(date: day){
                                            Capsule()
                                                .fill(.orange)
                                                .matchedGeometryEffect(id: "CURRENTDAY", in: animation)
                                        }
                                        
                                    }
                                    
                                )
                                .contentShape(Capsule())
                                .onTapGesture {
                                    withAnimation{
                                        taskModel.currentDay = day
                                    }
                                }
                                
                                
                                
                            }
                        }
                        .padding(.horizontal)
                    }
                    TasksView()
                    
                } header: {
                    HeaderView()
                        
                }
                
                
            }
        }
        .ignoresSafeArea(.container, edges: .top)

    }
    
    //MARK: Tasks View
    func TasksView()->some View{
        LazyVStack(spacing:30){
            if let tasks = taskModel.filteredTasks{
                if tasks.isEmpty{
                    Text("Uživaj u ostatku dana!☀️")
                        .font(.system(size:16))
                        .fontWeight(.light)
                    Text("Nema više zadataka za tebe danas!🎉")
                        .font(.system(size:16))
                        .fontWeight(.light)
                }
                else{
                    ForEach(tasks){ task in
                        TaskCardView(task: task)
                    }
                }
            }
            else{
                //MARK: Progress View
                ProgressView()
                    .offset(y: 100)
            }
        }
        .padding()
        .padding(.top)
        //MARK: Updating
        .onChange(of: taskModel.currentDay) { newValue in
            taskModel.filterTodaysTasks()
        }
        
    }
    
    
    //MARK: Task Card View
    func TaskCardView(task: Task)->some View{
        HStack(alignment: .top, spacing:15){
            VStack(spacing:10){
                Circle()
                    .fill(taskModel.isCurrentHour(date: task.taskDate) ? Color("OrangeTick") : .clear)
                    .frame(width: 15, height: 15)
                    .background(
                    Circle()
                        .stroke(Color("OrangeTick"),lineWidth: 1)
                        .padding(-3)
                    )
                    .scaleEffect(taskModel.isCurrentHour(date: task.taskDate) ? 1 : 0.8)
                
                Rectangle()
                    .fill(.gray)
                    .frame(width:3)
            }
            
            VStack{
                HStack(alignment: .top, spacing: 10){
                    
                    VStack(alignment: .leading, spacing: 12){
                        
                        Text(task.taskTitle)
                            .font(.title2.bold())
                            
                        Text(task.taskDescription)
                            .font(.callout)
                            
                    }
                    .hLeading()
                    
                    Text(task.taskDate.formatted(date:.omitted, time:.shortened))
                    
                                        
                }
                
                if taskModel.isCurrentHour(date: task.taskDate){
                    //MARK: Team Members
                    HStack(spacing:0){
                        HStack(spacing:-10){
                            ForEach(["User1","User2","User3"], id:\.self){ user in
                                
                                Image(user)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width:45, height: 45)
                                    .clipShape(Circle())
                                    .background(
                                    
                                        Circle()
                                            .stroke(.white, lineWidth: 2)
                                    
                                    )
                            }
                        }
                        .hLeading()
                        
                        //MARK: Check Button
                        Button{
                            
                        } label:{
                            Image(systemName: "checkmark")
                                .foregroundStyle(.green)
                                .padding(10)
                                .background(.white, in:RoundedRectangle(cornerRadius: 10))
                        }
                        
                    }
                    .padding(.top)
                }

                
            }
            .foregroundColor(taskModel.isCurrentHour(date: task.taskDate) ? .white : .black)
            .padding(taskModel.isCurrentHour(date: task.taskDate) ? 20 : 5)
            .hLeading()
            .padding(.bottom, taskModel.isCurrentHour(date: task.taskDate) ? 0 : 1)
            .background(
                Color("OrangeTick")
                    .cornerRadius(25)
                    .opacity(taskModel.isCurrentHour(date: task.taskDate) ? 1 : 0)
            
            )
        }
        .hLeading()
    }
    
    
    
    
    //MARK: Header
    func HeaderView()->some View{
        
        HStack(spacing:10){
            
            VStack(alignment: .leading, spacing:10){
                
                Text(Date().formatted(date: .abbreviated, time:.omitted))
                    .foregroundColor(.gray)

                Text("Today")
                    .font(.largeTitle.bold())
            }
            .hLeading()
            
            Button{
                
            } label: {
                Image("Profile")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 45, height: 45)
                    .clipShape(Circle())
            }
            
        }
        .padding()
        .padding(.top, getSafeArea().top)
        .background(Color.white)
    }
 
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
            .previewInterfaceOrientation(.portrait)
    }
}

//MARK: UI Pomocne dizajn funkcije
//Ove ekstenzije ce izbeci koriscenje Spacer() i .frame(), a samim tim ce i kod biti dosta citljiviji

extension View{
    
    func hLeading()->some View{
        self
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    func hTrailing()->some View{
        self
            .frame(maxWidth: .zero, alignment: .trailing)
    }
    
    func hCenter()->some View{
        self
            .frame(maxWidth: .zero, alignment: .center)
    }
    
    
    //MARK: Safe Area
    func getSafeArea()->UIEdgeInsets{
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else{
            return .zero
        }
        
        guard let safeArea = screen.windows.first?.safeAreaInsets else{
            return .zero
        }
        
        return safeArea
    }
}
