//
//  FavoriteDataSource.swift
//  TheMovieDB
//
//  Created by Ferry Adi Wijayanto on 07/05/20.
//  Copyright © 2020 Ferry Adi Wijayanto. All rights reserved.
//

import UIKit

class FavoriteDataSource: NSObject, UITableViewDataSource {
    var items = [Movie]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.cellID, for: indexPath)
        
        return cell
    }
    
    
}
