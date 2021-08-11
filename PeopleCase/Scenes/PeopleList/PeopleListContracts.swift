//
//  PeopleListContracts.swift
//  PeopleCase
//
//  Created by Mert on 10.08.2021.
//

import Foundation

protocol PeopleListViewModelProtocol {
    var delegate: PeopleListViewModelDelegate? { get set }
    func load()
}

enum PeopleListViewModelOutput: Equatable {
    case setLoading(Bool)
    case setRefreshController(Bool)
    case setError(String)
    case showPeopleList([PeopleListPresentation])
}

protocol PeopleListViewModelDelegate: AnyObject {
    func handleViewModelOutput(_ output: PeopleListViewModelOutput)
}
