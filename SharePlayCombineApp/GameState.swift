//
//  GameState.swift
//  SharePlayCombineApp
//
//  Created by Michael Lustig on 6/27/21.
//

import Combine
import SwiftUI

enum Characters: String {
    case kirby
    case captian
    case pikachu
    case mario
}

class GameState: ObservableObject {
    @Published var characters = [
        Character(name: "kirby"),
        Character(name: "captain falcon"),
        Character(name: "pikachu"),
        Character(name: "mario")
  ]

}

class GameViewModel: ObservableObject {
    
    @Published var state = GameState()

    func characterClicked(_ clicked: Character) {
        clicked.status = .mine
    }
}

enum ChacterSelectionStatus {
    case availible
    case taken
    case mine
}

class Character {
    
    let name: String
    var status: ChacterSelectionStatus = .availible
    
    init( name: String) {
        self.name = name
    }
    
}
