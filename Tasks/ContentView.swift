//
//  ContentView.swift
//  Tasks
//
//  Created by Shahrukh on 13/12/2021.
//  Copyright © 2021 Programmer Force. All rights reserved.
//

import SwiftUI
import CoreData


struct ContentView: View {
    let coreDM: CoreDataManager
    @State var newToDo = ""
    @State private var tasks: [TodoItem] = [TodoItem]()
    @State var toggleImg : Bool = false
    
    var body: some View {
        NavigationView{
            ZStack{
                LinearGradient(gradient: .init(colors: [Color.init(red: 0.173, green: 0.239, blue: 0.388), Color.init(red: 0.678, green: 0.863, blue: 0.792)]), startPoint: .bottom, endPoint: .leading)
                    .edgesIgnoringSafeArea(.all)
                ZStack(alignment: .center){
                    VStack{
                        addNewTaskView
                        
                        List{
                            ForEach(self.tasks, id: \.self){ task in
                                ListRow(coreDM: self.coreDM, isChecked: task.isDone, task: task)
                                                                    
                            }
                                .onDelete(perform: self.delete)
                                .onMove(perform: self.move)
                            
                        }
                    }
                    .navigationBarTitle("Tasks")
                    .navigationBarItems(trailing: EditButton())
                        
                }.onAppear(perform: {
                    self.populateList()
                })
            }
        }
    }
    // Accepts the new task
    var addNewTaskView: some View{
        HStack{
            TextField("Enter new Task", text: $newToDo)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button("Add New"){
                self.addNewToDo()
                self.populateList()
            }
            .padding(5)
            .background(Color(red: 0, green: 0, blue: 0.5))
                //                .clipShape(Capsule())
                .foregroundColor(Color.white)
                .cornerRadius(5)
        }
        .padding()
    }
    // Add new todo
    func addNewToDo(){
        if !newToDo.isEmpty{
            coreDM.saveItem(id: String(tasks.count + 1), todo: newToDo)
            self.newToDo = ""
            
        }
    }
    // Move items in the list
    func move(from source: IndexSet, to destination: Int){
        tasks.move(fromOffsets: source, toOffset: destination)
    }
    // Delete item from list
    func delete(at offsets: IndexSet){
        coreDM.deleteItem(item: tasks[offsets.first!])
        populateList()
    }

    //PopulateList
    func populateList(){
        self.tasks = self.coreDM.getAllItems()
    }
}
//Custom list row
 struct ListRow: View {
    let coreDM: CoreDataManager
    @State var isChecked:Bool = false
    var task : TodoItem
    var body: some View {
        Button(action: {
            self.isChecked = !self.isChecked
            self.coreDM.updateItem(taskToUpdate: self.task, isDone: self.isChecked)
        })
        {
            HStack{
                Image(systemName: isChecked ? "checkmark.circle.fill": "checkmark.circle")
                Text(task.todoItem ?? "")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(coreDM: CoreDataManager())
    }
}

