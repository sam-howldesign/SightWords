//
//  AddWordView.swift
//  SightWords
//
//  Created by Sam Johnson on 10/5/20.
//

import SwiftUI

struct AddWordView: View {
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.presentationMode) var presentationMode
    
    @State private var word = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Word", text: $word)
                }
                
                Section {
                    Button("Save") {
                        let newWord = Word(context: self.viewContext)
                        newWord.name = self.word
                        
                        try? self.viewContext.save()
                        
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .navigationBarTitle("Add Word")
        }
    }
}

struct AddWordView_Previews: PreviewProvider {
    static var previews: some View {
        AddWordView()
    }
}
