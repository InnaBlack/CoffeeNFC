//
//  BaseCheckButton.swift
//  CoffeeNFC
//
//  Created by  inna on 02/08/2021.
//

import UIKit
import SnapKit


class BaseCheckView: UIView {
    
    var delegate: RadioButtonDelegate?
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.addTarget(self, action:#selector(onClick(sender:)), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    // Images
        let checkedImage = UIImage(named: "checked")! as UIImage
        let uncheckedImage = UIImage(named: "unchecked")! as UIImage
        
        // Bool property
        var isChecked: Bool = false {
            didSet {
                if isChecked == true {
                    button.setImage(checkedImage, for: UIControl.State.normal)
                } else {
                    button.setImage(uncheckedImage, for: UIControl.State.normal)
                }
            }
        }
    
    override func layoutSubviews() {
        addSubview(titleLabel)
        addSubview(button)

        titleLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(10.0)
        }
        
        button.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.right.equalToSuperview().offset(-10.0)
        }
        
    }
    
    func setTitle(title: String){
        titleLabel.text = title
        isChecked = false
    }

    @objc func onClick(sender: UIButton) {
            self.isChecked.toggle()
            delegate?.onClick(self)
    }
}
