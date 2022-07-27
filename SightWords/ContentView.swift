//
//  ContentView.swift
//  SightWords
//
//  Created by Sam Johnson on 10/5/20.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Word.name, ascending: true)],
        animation: .default)
    private var words: FetchedResults<Word>

    @State private var showingAddScreen = false
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: GameView()){
                    Text("Let's Do This!")
                }
                List {
                    ForEach(words) { word in
                        Text("\(word.name ?? "(empty)")")
                    }
                    .onDelete(perform: deleteWords)
                }
            }
            .navigationBarTitle("Sight Words")
            .navigationBarItems(
                leading: EditButton(),
                trailing:
                    Button(action: {
                        self.showingAddScreen = true
                    }){
                        Image(systemName: "plus")
                    }
            )
            .sheet(isPresented: $showingAddScreen) {
                AddWordView().environment(\.managedObjectContext, self.viewContext)
            }
            
            
        }
    }


    private func deleteWords(offsets: IndexSet) {
        withAnimation {
            offsets.map { words[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
