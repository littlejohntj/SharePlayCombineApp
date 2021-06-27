//
//  ContentView.swift
//  SharePlayCombineApp
//
//  Created by TJ Littlejohn on 6/19/21.
//

import GroupActivities
import SwiftUI
import Combine


struct ContentView: View {
    
    // What is the difference between @StateObject / @ObservedObject?
    // What is the proper way to model a ViewModel with SwiftUI for easiest array mutation
    @StateObject var gameViewModel = GameViewModel()
    
    var body: some View {
        VStack {
            ForEach(gameViewModel.state.characters) { character in
                CharacterButton(character: character, buttonCliked: gameViewModel.characterClicked)
            }
        }
    }
}

struct CharacterButton: View {
    
    let character: Character
    let buttonCliked: (Character) -> Void
    
    var body: some View {
        Button(character.name) {
            buttonCliked(character)
        }
        .buttonStyle( CharacterButtonStyle(character: character) )
        .padding()
    }
    
}


struct CharacterButtonStyle: ButtonStyle {
    
    let character: Character
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background( character.status == .mine ? Color.blue : Color.red )
            .foregroundColor(.white)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
