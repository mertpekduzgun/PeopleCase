//
//  PeopleListBuilder.swift
//  PeopleCase
//
//  Created by Mert on 10.08.2021.
//

import UIKit

final class PeopleListBuilder {
    static func make() -> PeopleListViewController {
        let storyboard = UIStoryboard(name: "PeopleList", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "PeopleListViewController") as! PeopleListViewController
        viewController.viewModel = PeopleListViewModel()
        
        return viewController
    }
}
