//
//  CoffeeMainScreenViewController.swift
//  CoffeeNFC
//
//  Created by  inna on 01/08/2021.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

protocol CoffeeMainScreenViewControllerProtocol {
    func showLoader()
    func hideLoader()
}

extension CoffeeMainScreenView {
    struct Appearance {
        let titleLabeHeight = 33.0
        
    }
}

final class CoffeeMainScreenView: BaseViewController {
    
    private let appearance = Appearance()
    private let disposeBag = DisposeBag()
    var presenter: CoffeeMainScreenPresenterProtocol!
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: "Avenir Next", size: 16.0)
        label.text = "Select your style"
        label.backgroundColor = .white
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Brew with Lex"
        navigationController?.navigationBar.tintColor = .black
        navigationItem.backButtonDisplayMode = .minimal
        presenter.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        
        addSubviews()
        makeConstraints()
        presenter.coffeeTableManager?.setupTable(tableView: tableView, type: .type)
    }
    
    func addSubviews() {
        view.addSubview(titleLabel)
        view.addSubview(tableView)
    }
    
    func makeConstraints() {
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16.0)
            make.leading.trailing.equalToSuperview().offset(16.0)
            make.height.equalTo(self.appearance.titleLabeHeight)
        }
        
        tableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(16.0)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}

extension CoffeeMainScreenView: CoffeeMainScreenViewControllerProtocol {
    
    func showLoader() {
        showActivityIndicator()
    }
    
    func hideLoader() {
        hideActivityIndicator()
    }
}
