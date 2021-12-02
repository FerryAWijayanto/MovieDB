//
//  Extension+UIViewController.swift
//  MovieDB
//
//  Created by Ferry Adi Wijayanto on 30/11/21.
//

import UIKit.UIViewController

fileprivate var containerView: UIView?

extension UIViewController {
    
    func showLoadingView() {
        let spinnerView = UIView.init(frame: view.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .large)
        ai.color = .systemBlue
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            self.view.addSubview(spinnerView)
        }
                
        containerView = spinnerView
    }
    
    func dismissLoadingView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            containerView?.removeFromSuperview()
            containerView = nil
        }
    }
    
    func alertMessage(title: String, message: String, buttonTitle: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: nil))
        present(alertVC, animated: true)
    }
}
