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
        title = "Brew with Lex"
        presenter.viewDidLoad()
        setupUI()
    }

    func setupUI() {

        addSubviews()
        makeConstraints()
        presenter.coffeeTableManager?.setupTable(tableView: tableView)
    }
    
    func addSubviews() {
        view.addSubview(titleLabel)
        view.addSubview(tableView)
    }
    
    func makeConstraints() {
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(self.appearance.titleLabeHeight)
        }
        
        tableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom)
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
