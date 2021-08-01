//
//  CoffeeCell.swift
//  CoffeeNFC
//
//  Created by  inna on 01/08/2021.
//

import UIKit

class CoffeeTableViewCell: UITableViewCell {
    
    let labelColor: UIColor = .white
    let backGroundColor =  UIColor(rgb: 0xAED7A0)
    let labelFont = UIFont(name: "Lungo", size: 14.0)
    let imageSize = 46.0
    let rowHeight = 94.0
    
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
    
    
    var viewModel: CoffeeViewModel? {
        didSet {
            guard let viewModel = self.viewModel  else {
                return
            }
            titleLabel.text = viewModel.name
            imageV.image = UIImage(named: viewModel.name.lowercased())
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
    }
    
    private func makeConstraints() {
        
        view.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(rowHeight)
        }
        
        imageV.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.width.equalTo(imageSize)
            make.leading.equalToSuperview().offset(23.0)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(imageV.snp.trailing).offset(23.0)
            make.trailing.equalToSuperview()
        }
    }
}


extension UITableViewCell {
    public static var reuseIdentifier: String {
        String(describing: self)
    }
}
