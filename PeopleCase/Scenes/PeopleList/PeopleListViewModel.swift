//
//  PeopleListViewModel.swift
//  PeopleCase
//
//  Created by Mert on 10.08.2021.
//

import Foundation

final class PeopleListViewModel: PeopleListViewModelProtocol {
       
    weak var delegate: PeopleListViewModelDelegate?
    private var response: FetchResponse?
    private var error: FetchError?
    private var people: [Person] = []
    
    private var page: String = "0"
    
    func load() {
        notify(.setLoading(true))
        DataSource.fetch(next: page) { [weak self] response, error in
            guard let self = self else { return }
            self.notify(.setLoading(false))
            
            guard response != nil else {
                self.notify(.setError(error?.errorDescription ?? "Unexpected Error"))
                return
            }
            
            self.people = response!.people
            let presentations = response?.people.map({ PeopleListPresentation(person: $0) })
            self.notify(.showPeopleList(presentations!))
            self.notify(.setRefreshController(true))
            self.page = response?.next ?? "0"
        }
    }
    
    private func notify(_ output: PeopleListViewModelOutput) {
        delegate?.handleViewModelOutput(output)
    }
}
