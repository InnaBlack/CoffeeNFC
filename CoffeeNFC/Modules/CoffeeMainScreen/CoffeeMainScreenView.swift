//
//  CoffeeMainScreenViewController.swift
//  CoffeeNFC
//
//  Created by  inna on 01/08/2021.
//

import UIKit
//import SnapKit
import RxSwift
import RxCocoa

protocol CoffeeMainScreenViewControllerProtocol {
    func showLoader()
    func hideLoader()
}

extension CoffeeMainScreenView {
    struct Appearance {

    }
}

final class CoffeeMainScreenView: BaseViewController {
    
    private let appearance = Appearance()
    private let disposeBag = DisposeBag()
    var presenter: CoffeeMainScreenPresenterProtocol!
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        return tableView
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.viewDidLoad()
        setupUI()
    }

    func setupUI() {

        addSubviews()
        makeConstraints()
        presenter.coffeeTableManager?.setupTable(tableView: tableView)
    }
    
    func addSubviews() {
        view.addSubview(tableView)
    }
    
    func makeConstraints() {
//        tableView.snp.makeConstraints { make in
//            make.leading.trailing.equalToSuperview()
//            make.top.equalTo(searchField.snp.bottom).offset(appearance.topMargin)
//            make.bottom.equalTo(viewBackground.safeAreaLayoutGuide.snp.bottom)
//        }
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
