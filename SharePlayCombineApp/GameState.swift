//
//  GameState.swift
//  SharePlayCombineApp
//
//  Created by Michael Lustig on 6/27/21.
//

import Combine
import SwiftUI

class GameState: ObservableObject {
  private let characters = [
        Character(name: "kirby", status: .availible),
        Character(name: "captain falcon", status: .availible),
        Character(name: "pikachu", status: .availible),
        Character(name: "mario", status: .availible)
  ].reduce(into: [:]) { dict, character in
      dict[character.name] = character
  }

    
  
}

class GameViewModel: ObservableObject {
    
    @Published var state = GameState()

    func characterClicked(_ clicked: Character) {
        self.characters
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
