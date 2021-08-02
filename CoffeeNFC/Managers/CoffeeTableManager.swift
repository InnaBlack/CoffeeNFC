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
    func setupTable(tableView: UITableView, type: CoffeeTableManager.TableManagerType)
    func updateTable(with model: [CoffeeViewModelProtocol])
}

final class CoffeeTableManager: NSObject {
    
    weak var delegate: CoffeeTableManagerDelegate?
    private weak var tableView: UITableView?
    private var typeTableView: TableManagerType?
    private var viewModel: [CoffeeViewModelProtocol]? {
        didSet {
            tableView?.reloadData()
        }
    }
    
    private func makeTableViewUnscrollableIfNeeded() {

    }
    
    init(withDelegate delegate: CoffeeTableManagerDelegate?) {
        self.delegate = delegate
    }
    
}

extension CoffeeTableManager: CoffeeTableManagerProtocol {
    
    func setupTable(tableView: UITableView, type: TableManagerType) {
        self.typeTableView = type
        self.tableView = tableView
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.rowHeight = type == .extra ? 150.0 : 102.0
        
        if (self.typeTableView == .extra) {
            self.tableView?.register(CoffeeExtraTableViewCell.self, forCellReuseIdentifier: CoffeeExtraTableViewCell.reuseIdentifier)
        } else {
            self.tableView?.register(CoffeeTableViewCell.self, forCellReuseIdentifier: CoffeeTableViewCell.reuseIdentifier)
        }
    }
    func updateTable(with model: [CoffeeViewModelProtocol]) {
        self.viewModel = model
    }
}


extension CoffeeTableManager {
    enum TableManagerType {
        case type
        case size
        case extra
    }
}


extension CoffeeTableManager: UITableViewDataSource, UITableViewDelegate {
    
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (self.typeTableView == .extra) {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CoffeeExtraTableViewCell.reuseIdentifier, for: indexPath) as? CoffeeExtraTableViewCell else {
                return UITableViewCell(style: .default, reuseIdentifier: nil)
            }
            cell.viewModel = viewModel?[indexPath.row] as? ExtraCoffeeViewModel
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CoffeeTableViewCell.reuseIdentifier, for: indexPath) as? CoffeeTableViewCell else {
                return UITableViewCell(style: .default, reuseIdentifier: nil)
            }
            cell.viewModel = viewModel?[indexPath.row]
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectRowAt(indexPath: indexPath)
    }
}
