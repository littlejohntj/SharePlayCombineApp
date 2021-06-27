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
    @StateObject var count = Count()

    
    
    var body: some View {
        
        VStack {
            HStack {
                Button("-", action: {count.decrementCount()})
                    .padding()
                Text("\(count.count)")
                Button("+", action: {count.incrementCount()})
                    .padding()
            }
            Button("Activate", action: { TypeTogether().activate() })
                .padding()
        }
        .font(.largeTitle)
        
        .task {
            for await session in TypeTogether.sessions() {
                count.configureGroupSession(session)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
