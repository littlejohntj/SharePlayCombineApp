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
            ForEach(gameViewModel.state.characters, id: \.self) {character in
                Button(character) {
                    gameViewModel.characterSelected(character)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
