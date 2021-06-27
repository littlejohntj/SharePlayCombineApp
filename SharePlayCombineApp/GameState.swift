//
//  GameState.swift
//  SharePlayCombineApp
//
//  Created by Michael Lustig on 6/27/21.
//

import Combine
import SwiftUI

class GameState: ObservableObject {
    var characters = [
        Character(name: "kirby", status: .availible),
        Character(name: "captain falcon", status: .availible),
        Character(name: "pikachu", status: .availible),
        Character(name: "mario", status: .availible)
  ]

}

class GameViewModel: ObservableObject {
    
    var state = GameState()

    func characterClicked(_ clicked: Character) {
        print("clicked it")
        self.state.characters = [Character(name: "pikachu", status: .availible)]
        print(self.state.characters)
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
