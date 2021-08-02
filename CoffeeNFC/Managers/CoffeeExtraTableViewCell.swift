//
//  CoffeeExtraTableViewCell.swift
//  CoffeeNFC
//
//  Created by  inna on 02/08/2021.
//

import UIKit

protocol RadioButtonDelegate {
    func onClick(_ sender: UIView)
}

class CoffeeExtraTableViewCell: UITableViewCell {
    
    let labelColor: UIColor = .white
    let backGroundColor =  UIColor(rgb: 0xAED7A0)
    let labelFont = UIFont(name: "Lungo", size: 14.0)
    let imageSize = 46.0
    let rowHeight = 130.0
    
    private lazy var view: UIView = {
        let view = UIView()
        view.backgroundColor = backGroundColor
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = labelFont
        label.textColor = labelColor
        label.backgroundColor = .clear
        
        return label
    }()
    
    private lazy var imageV: UIImageView = {
        let imageView = UIImageView(frame: CGRect.init(x: 0, y: 0, width: imageSize, height: imageSize))
        return imageView
    }()
    
    private lazy var radioButton1: BaseCheckView = {
        BaseCheckView()
    }()
    
    private lazy var radioButton2: BaseCheckView = {
        BaseCheckView()
    }()
    
    private lazy var stackOptionButtons: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [radioButton1, radioButton2])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        return stackView
    }()
    
    var viewModel: ExtraCoffeeViewModel? {
        didSet {
            guard let viewModel = self.viewModel  else {
                return
            }
            titleLabel.text = viewModel.name
            imageV.image = UIImage(named: viewModel.name.lowercased())
            radioButton1.setTitle(title: viewModel.subselections[0].name)
            radioButton1.delegate = self
            radioButton2.setTitle(title: viewModel.subselections[1].name)
            radioButton2.delegate = self
        }
    }
    
    // MARK: View Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = .white
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    // MARK: Private functions
    
    private func setupUI() {
        self.addSubviews()
        self.makeConstraints()
    }
    
    private func addSubviews() {
        self.contentView.addSubview(view)
        self.view.addSubview(imageV)
        self.view.addSubview(titleLabel)
        self.view.addSubview(stackOptionButtons)
    }
    
    private func makeConstraints() {
        
        view.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(16.0)
            make.trailing.equalToSuperview().offset(-16.0)
            make.height.equalTo(rowHeight)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.height.equalTo(44.0)
            make.left.equalToSuperview().offset(10.0)
        }
        
        stackOptionButtons.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

extension CoffeeExtraTableViewCell: RadioButtonDelegate {
    func onClick(_ sender: UIView) {
        guard let currentRadioButton = sender as? BaseCheckView else {
            return
          }

          [ radioButton1,
            radioButton2
          ].forEach { $0.isChecked = false }
          currentRadioButton.isChecked = !currentRadioButton.isChecked
    }
}

