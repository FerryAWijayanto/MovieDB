//
//  MainTabBarController.swift
//  TheMovieDB
//
//  Created by Ferry Adi Wijayanto on 06/05/20.
//  Copyright © 2020 Ferry Adi Wijayanto. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        viewControllers = [
            createViewController(PopularViewController(), title: "Popular", image: #imageLiteral(resourceName: "interface-2")),
            createViewController(FavoriteViewController(), title: "Favorite", image: #imageLiteral(resourceName: "love-and-romance"))
        ]
    }

}

extension MainTabBarController {
    private func createViewController(_ rootViewController: UIViewController, title: String, image: UIImage) -> UINavigationController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image.withRenderingMode(.alwaysOriginal)
        return navController
    }
}
