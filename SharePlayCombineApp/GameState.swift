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
    
    @Published var items = [
        Thing("foo"),
        Thing("bar")
    ]

    func characterClicked(_ clicked: Character) {
        self.state.characters = self.state.characters.map{ character in
            if (character.status == .mine) {
                character.status = .availible
            }
            return character
        }
        let characters = self.state.characters
        
        

        let i = characters.firstIndex(where: {$0.id == clicked.id})!
        let character = characters[i]
        let status = character.status
        
        print(status)
        
        var newStatus: ChacterSelectionStatus = .mine
        switch status {
        case .mine:
            newStatus = .availible
        case .availible:
            newStatus = .mine
        case .taken:
            fatalError("TJ says get rekt")
        }
        
        print(newStatus)
        
        self.state.characters[i].status = newStatus
    }
    
    func thingClicked(_ thing: Thing) {
//        thing.name = "was clicked dummy \(UUID().uuidString)"
        items.append(Thing(UUID().uuidString))
        items[0] = Thing("whatever")
    }
}


struct Thing: Identifiable {
    var id = UUID()
    var name: String
    
    init(_ name: String) {
        self.name = name
    }
}

enum ChacterSelectionStatus {
    case availible
    case taken
    case mine
}

class Character: Identifiable {
    
    var id = UUID()
    var name: String
    var status: ChacterSelectionStatus = .availible
    
    init( name: String) {
        self.name = name
    }
    
}
