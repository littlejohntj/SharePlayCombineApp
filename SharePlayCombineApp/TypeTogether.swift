//
//  GroupTyping.swift
//  SharePlayCombineApp
//
//  Created by TJ Littlejohn on 6/19/21.
//

import Foundation
import GroupActivities

struct TypeTogether: GroupActivity {
    
    var metadata: GroupActivityMetadata {
        
        var metadata = GroupActivityMetadata()
        metadata.title = NSLocalizedString("Type Together",
                                           comment: "Title of my group activity")
        metadata.type = .generic
        return metadata
    }

}
