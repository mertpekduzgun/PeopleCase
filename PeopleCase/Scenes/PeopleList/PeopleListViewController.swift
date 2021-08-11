//
//  PeopleListViewController.swift
//  PeopleCase
//
//  Created by Mert on 10.08.2021.
//

import UIKit

final class PeopleListViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    var viewModel: PeopleListViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    private var peopleList: [PeopleListPresentation] = []
    private var refreshControl = UIRefreshControl()
    private var emptyTableViewMessage = "No one here :)"
    
    //    MARK: Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        tableView.dataSource = self
        tableView.refreshControl = self.refreshControl
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        viewModel.load()
    }
    
    func setTableView() {
        tableView.register(PeopleListTableViewCell.self) 
        tableView.tableFooterView = UIView()
    }
    
    func showAlert(errorMessage: String) {
        let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { action in
            self.viewModel.load()
        }))
        
        self.present(alert, animated: true)
    }
    
    @objc
    func refresh() {
        viewModel.load() 
    }
}

extension PeopleListViewController: PeopleListViewModelDelegate {
    
    func handleViewModelOutput(_ output: PeopleListViewModelOutput) {
        switch output {
        case .setLoading(let isLoading):
            if isLoading {
                self.emptyTableViewMessage = "Loading..."
            } else {
                self.emptyTableViewMessage = "No one here :)"
            }
        case .setRefreshController(let isRefreshed):
            if isRefreshed {
                self.refreshControl.endRefreshing()
            }
        case .showPeopleList(let peopleList):
            
            let peopleIds = Set(self.peopleList.lazy.map({$0.id}))
            
            if self.peopleList.count == 0 {
                self.peopleList.append(contentsOf: peopleList)
            } else {
                for person in peopleList {
                    if !peopleIds.contains(person.id) {
                        self.peopleList.append(person)
                    } else {
                        print("ID is already in list", person.id)
                    }
                }
            }
        
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        case .setError(let errorMessage):
            DispatchQueue.main.async {
                self.showAlert(errorMessage: errorMessage)
            }
        }
    }
}

extension PeopleListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if peopleList.count == 0 {
            DispatchQueue.main.async {
                self.tableView.setEmptyMessage(self.emptyTableViewMessage)
            }
        } else {
            DispatchQueue.main.async {
                self.tableView.setEmptyMessage("")
            }
            return peopleList.count
        }
        
        return peopleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(for: indexPath, cellType: PeopleListTableViewCell.self)
        let person = peopleList[indexPath.row]
        
        cell.fullNameLabel.text = person.fullName + " (" + "\(person.id)" + ")"
        
        return cell
    }
}


