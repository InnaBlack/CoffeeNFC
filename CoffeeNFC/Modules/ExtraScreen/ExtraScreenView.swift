//
//  ExtraScreenViewController.swift
//  CoffeeNFC
//
//  Created by  inna on 01/08/2021.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

protocol ExtraScreenViewControllerProtocol {
    func showLoader()
    func hideLoader()
}

extension ExtraScreenView {
    struct Appearance {
        let titleLabeHeight = 33.0
        
    }
}

final class ExtraScreenView: BaseViewController {
    
    private let appearance = Appearance()
    private let disposeBag = DisposeBag()
    var presenter: ExtraScreenPresenterProtocol!
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Select your extra’s"
        label.font = UIFont(name: "Avenir Next", size: 16.0)
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
        title = "Brew with Lex"
        self.view.backgroundColor = .white
        presenter.viewDidLoad()
        setupUI()
    }

    func setupUI() {

        addSubviews()
        makeConstraints()
        presenter.coffeeTableManager?.setupTable(tableView: tableView, type: .extra)
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

extension ExtraScreenView: ExtraScreenViewControllerProtocol {
    
    func showLoader() {
        showActivityIndicator()
    }
    
    func hideLoader() {
        hideActivityIndicator()
    }
}
