//
//  Home.swift
//  Task Management App
//
//  Created by Aleksa Dimitrijevic on 13.6.22..
//

import SwiftUI

struct Home: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){

            //MARK: Lazy stack with pinned header
            LazyVStack(spacing:15, pinnedViews: [.sectionHeaders]) {
                
                
                Section{
                //MARK: Current Week View
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack(spacing:10){
                            
                        }
                    }
                    
                } header: {
                    HeaderView()
                }
                
                
            }
        }

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
        .background(Color.white)
    }
 
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
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
}
