//
//  UIHelper.swift
//  MovieDB
//
//  Created by Ferry Adi Wijayanto on 30/11/21.
//

import UIKit

enum UIHelper {
    
    static func createCollectionViewFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        let width                           = view.bounds.width
        let padding: CGFloat                = 12
        let minimumInterimSpacing: CGFloat  = 10
        let availableWidth                  = width - (padding * 2) - (minimumInterimSpacing * 2)
        let itemWidth                       = availableWidth / 3
        
        let flowLayout                      = UICollectionViewFlowLayout()
        flowLayout.sectionInset             = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize                 = CGSize(width: itemWidth, height: itemWidth + 40)
        return flowLayout
    }
    
    static func createReviewFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        let width = view.bounds.width
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        flowLayout.itemSize = CGSize(width: width, height: 120)
        return flowLayout
    }
}
