//
//  CoffeeTableManager.swift
//  CoffeeNFC
//
//  Created by  inna on 01/08/2021.
//

import Foundation
import UIKit


protocol CoffeeTableManagerDelegate: AnyObject {
    func didSelectRowAt(indexPath: IndexPath)
}

protocol CoffeeTableManagerProtocol {
    associatedtype ViewModel
    func setupTable(tableView: UITableView)
    func updateTable(with model: [ViewModel])
}

final class CoffeeTableManager: NSObject {
    
    typealias ViewModel = CoffeeViewModel // & Reusable & Configurable
    
    weak var delegate: CoffeeTableManagerDelegate?
    private weak var tableView: UITableView?
    private var viewModel: [ViewModel]? {
        didSet {
            tableView?.reloadData()
        }
    }
    
    private func makeTableViewUnscrollableIfNeeded() {

    }
}

extension CoffeeTableManager: CoffeeTableManagerProtocol {
    
    func setupTable(tableView: UITableView) {
        self.tableView = tableView
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.register(CoffeeTableViewCell.self, forCellReuseIdentifier: CoffeeTableViewCell.reuseIdentifier)
    }
    
    func updateTable(with model: [ViewModel]) {
        viewModel = model
    }
}

extension CoffeeTableManager: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CoffeeTableViewCell.reuseIdentifier, for: indexPath)
        //cell.textLabel?.text = viewModel?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectRowAt(indexPath: indexPath)
    }
}
