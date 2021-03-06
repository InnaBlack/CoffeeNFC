//
//  SizeScreenViewController.swift
//  CoffeeNFC
//
//  Created by  inna on 01/08/2021.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

protocol SizeScreenViewControllerProtocol {
    func showLoader()
    func hideLoader()
}

extension SizeScreenView {
    struct Appearance {
        let titleLabeHeight = 33.0
        
    }
}

final class SizeScreenView: BaseViewController {
    
    private let appearance = Appearance()
    private let disposeBag = DisposeBag()
    var presenter: SizeScreenPresenterProtocol!
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: "Avenir Next", size: 16.0)
        label.text = "Select your size"
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
        self.view.backgroundColor = .white
        title = "Brew with Lex"
        presenter.viewDidLoad()
        setupUI()
    }

    func setupUI() {

        addSubviews()
        makeConstraints()
        presenter.coffeeTableManager?.setupTable(tableView: tableView, type: .size)
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

extension SizeScreenView: SizeScreenViewControllerProtocol {
    
    func showLoader() {
        showActivityIndicator()
    }
    
    func hideLoader() {
        hideActivityIndicator()
    }
}
