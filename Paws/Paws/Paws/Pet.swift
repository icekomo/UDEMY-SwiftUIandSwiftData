//
//  Pet.swift
//  Paws
//
//  Created by Josh Gdovin on 7/7/25.
//

import Foundation
import SwiftData

@Model
final class Pet {
    var name: String
    @Attribute(.externalStorage) var photo: Data?
    
    init(name: String, photo: Data? = nil) {
        self.name = name
        self.photo = photo
    }
    
}

extension Pet {
    @MainActor
    static var preview: ModelContainer {
        let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: Pet.self, configurations: configuration)
        container.mainContext.insert(Pet(name: "Ziggy"))
        container.mainContext.insert(Pet(name: "Oliver"))
        container.mainContext.insert(Pet(name: "Winson"))
        container.mainContext.insert(Pet(name: "Bernard"))
        container.mainContext.insert(Pet(name: "Buster"))
        container.mainContext.insert(Pet(name: "Bubba"))
        container.mainContext.insert(Pet(name: "Twinkie"))
        container.mainContext.insert(Pet(name: "Nugget"))
        
        return container
    }
}
