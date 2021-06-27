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
        Character(name: "kirby", status: .availible),
        Character(name: "captain falcon", status: .availible),
        Character(name: "pikachu", status: .availible),
        Character(name: "mario", status: .availible)
    ]
}

class GameViewModel: ObservableObject {
    
    @Published var state = GameState()

    func characterSelected(_ character: String) {
        print("\(character) clicked by <TODO USER>")
//        publishCharacterSelected(character)
    }
}

enum ChacterSelectionStatus {
    case availible
    case taken
    case mine
}

struct Character {
    
    let name: String
    let status: ChacterSelectionStatus
    
}
