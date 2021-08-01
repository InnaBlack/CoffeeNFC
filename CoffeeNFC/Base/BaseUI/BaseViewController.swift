//
//  BaseViewController.swift
//  CoffeeNFC
//
//  Created by  inna on 01/08/2021.
//

import UIKit
import RxSwift

extension BaseViewController {
    struct BaseAppearance {
        let backgroundColor: UIColor = .white
    }
}


class BaseViewController: UIViewController {
    
    // MARK: Private properties
    private let appearance = BaseAppearance()
    
    private let disposeBag = DisposeBag()
    
    // MARK: UI properties

    private lazy var indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .whiteLarge)
        indicator.hidesWhenStopped = true
        return indicator
    }()

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    private func setupUI() {
        addSubviews()
        makeConstraints()
    }
    
    private func addSubviews() {
        self.view.addSubview(indicator)
    }
    
    private func makeConstraints() {
     
//        indicator.snp.makeConstraints { make in
//            make.centerY.equalToSuperview()
//            make.width.equalTo(25.0)
//            make.left.equalToSuperview()
//        }
    }

    // MARK: Functions
    func showActivityIndicator() {
        indicator.isHidden = false
        self.view.bringSubviewToFront(indicator)
    }
    
    func hideActivityIndicator() {
        DispatchQueue.main.async { [weak self] in
            self?.indicator.isHidden = true
        }
    }
}
