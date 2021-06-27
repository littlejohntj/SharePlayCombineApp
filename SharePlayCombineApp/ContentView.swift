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
    
    @StateObject var gameViewModel = GameViewModel()
    
    var body: some View {
        VStack {
            ForEach(gameViewModel.state.characters, id: \.self.name) {character in
                CharacterButton(character: character)
            }
        }
    }
}

struct CharacterButton: View {
    
    let character: Character
    
    var body: some View {
        Button(character.name) {
            print("selected \(character)")
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
            .background( character.name.split(separator: " ").count > 1 ? Color.red : Color.blue )
            .foregroundColor(.white)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
