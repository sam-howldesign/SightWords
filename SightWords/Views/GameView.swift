//
//  GameView.swift
//  SightWords
//
//  Created by Sam Johnson on 10/5/20.
//

import SwiftUI
import CoreData

struct GameView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Word.name, ascending: true)],
        animation: .default)
    private var words: FetchedResults<Word>
        
    @State private var word = ""
    
    var body: some View {
        VStack {
            Text("\(word)")
                .font(.system(size: 72.0))
                .fontWeight(.heavy)
                .padding(.bottom, 200)
            
            
            Button("Next"){
                newWord()
            }
            
        }
        .onAppear {
            newWord()
        }
    }
    
    
    func newWord(){
        let randomDBEntry = words.randomElement()!
        self.word = randomDBEntry.name ?? "(empty)"
    }
    
    
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
