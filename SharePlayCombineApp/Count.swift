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
                    print("Send failed: \(error)")
                }
            }
        }
    }
    
/*
 
 [message received publish subject<====
 
 pipeline 1
 
 pipeline 2
 
 pipeline 3
 
 
 */
    
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
       
        /**

         More developer friendly API here
         
         observe(CharacterSelectionMessage.self) { message in
        
         }
             .sink { characterSelectedMessage in handlerItHere}
         
         task tracking would have to happen by the observe call class
    
         */
        
//        let characterSelectedMessageListenerTask = detach { [weak self] in
//            for await (message, _) in messenger.messages(of: CharacterSelectionMessage.self) {
//                self?.handleCharacterChosenMessage(message: message)
//            }
//        }
        tasks.insert(countTask)
//        tasks.insert(characterSelectedMessageListenerTask)
        
        groupSession.join()
    }
    
    func handle( message: CountMessage ) {
        DispatchQueue.main.async {
            self.count = message.count
        }
    }
    
//    func handle( message: CharacterSelectionMessage ) {
//        DispatchQueue.main.async {
//            self.count = message.count
//        }
//    }
    
}
