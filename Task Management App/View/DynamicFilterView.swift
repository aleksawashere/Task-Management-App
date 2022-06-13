//
//  DynamicFilterView.swift
//  Task Management App
//
//  Created by Aleksa Dimitrijevic on 14.6.22..
//

import SwiftUI
import CoreData

struct DynamicFilterView<Content: View,T>: View where T: NSManagedObject {
    
    //MARK: Core Data Request
    @FetchRequest var request: FetchedResults<T>
    let content: (T)->Content
    
    //MARK: Building Custom ForEach which will give CoreData object to build View
    init(dateToFilter: Date, @ViewBuilder content: @escaping (T)->Content){
        //Initializing Request with NSPredicate
        _request = FetchRequest(entity: T.entity(), sortDescriptors: [], predicate: nil)
        self.content = content
    }
    
    var body: some View {
        Group{
            if request.isEmpty{
                Text("Uživaj u ostatku dana!☀️")
                    .font(.system(size:16))
                    .fontWeight(.light)
                Text("Nema više zadataka za tebe danas!🎉")
                    .font(.system(size:16))
                    .fontWeight(.light)
            }
            else{
                ForEach(request,id: \.objectID){object in
                    self.content(object)
                }
            }
        }
    }
}
