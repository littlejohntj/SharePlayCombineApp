//
//  Count.swift
//  SharePlayCombineApp
//
//  Created by TJ Littlejohn on 6/19/21.
//

import Foundation
import GroupActivities
import Combine

struct CountMessage: Codable {
    
    let id: UUID
    let count: Int
    
}

class Count: ObservableObject {
    
    @Published var count = 0
    @Published var groupSession: GroupSession<TypeTogether>?
    var messenger: GroupSessionMessenger?
    
    var subscriptions = Set<AnyCancellable>()
    var tasks = Set<Task.Handle<Void, Never>>()
    
    func incrementCount() {
        count += 1
        dispatchChanges()
    }
    
    func decrementCount() {
        count -= 1
        dispatchChanges()
    }
    
    func dispatchChanges() {
        
        if let messenger = messenger {
            async {
                do {
                    try await messenger.send( CountMessage(id: UUID(), count: count) )
                } catch {
                    // bleh
                }
            }
        }
    }
    
    func configureGroupSession( _ groupSession: GroupSession<TypeTogether> ) {
        count = 0
        self.groupSession = groupSession
        let messenger = GroupSessionMessenger(session: groupSession)
        self.messenger = messenger
        
        let countTask = detach { [weak self] in
            for await (message, _) in messenger.messages(of: CountMessage.self) {
                self?.handle(message: message)
            }
        }
        tasks.insert(countTask)
        
        groupSession.join()
    }
    
    func handle( message: CountMessage ) {
        count = message.count
    }
    
}
