//
//  GameState.swift
//  SharePlayCombineApp
//
//  Created by Michael Lustig on 6/27/21.
//

import Combine
import SwiftUI

class GameState: ObservableObject {
    @Published var characters = [
        "kirby",
        "captain falcon",
        "pikachu",
        "mario"
    ]
}

class GameViewModel: ObservableObject {
    
    @Published var state = GameState()

    func characterSelected(_ character: String) {
        print("\(character) clicked by <TODO USER>")
//        publishCharacterSelected(character)
    }
}
