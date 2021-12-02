//
//  EmptyView.swift
//  MovieDB
//
//  Created by Ferry Adi Wijayanto on 01/12/21.
//

import UIKit

class EmptyView: UIView {
    
    static let id = "EmptyView"
    
    private let emptyMessage: UILabel = {
        let messageLabel = UILabel()
        messageLabel.text = "Reviews not available"
        messageLabel.textColor = .systemGray
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        messageLabel.sizeToFit()
        return messageLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(emptyMessage)
        emptyMessage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            emptyMessage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            emptyMessage.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 100)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
