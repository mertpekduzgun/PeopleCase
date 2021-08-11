//
//  PeopleListPresentation.swift
//  PeopleCase
//
//  Created by Mert on 10.08.2021.
//

import Foundation

struct PeopleListPresentation: Equatable {
    var id: Int
    var fullName: String
    
    public init(id: Int,
                fullName: String) {
        
        self.id = id
        self.fullName = fullName
    }
}

extension PeopleListPresentation {
    init(person: Person) {
        self.init(id: person.id,
                  fullName: person.fullName)
    }
}
