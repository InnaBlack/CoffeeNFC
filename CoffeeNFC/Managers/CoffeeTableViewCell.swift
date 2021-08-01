//
//  CoffeeCell.swift
//  CoffeeNFC
//
//  Created by  inna on 01/08/2021.
//

import UIKit

extension CoffeeTableViewCell {
    
    struct appearance {
       
    }
}

class CoffeeTableViewCell: UITableViewCell {
    
    var viewModel: CoffeeViewModel? {
        didSet {
          
        }
    }
    
    // MARK: View Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
       // self.contentView.addSubview() todo
    }
    
    private func makeConstraints() {
        
    }
}


extension UITableViewCell {
    public static var reuseIdentifier: String {
        String(describing: self)
    }
}
