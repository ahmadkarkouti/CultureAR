//
//  EventController.swift
//  CultureAR
//
//  Created by Ahmad Karkouty on 3/18/19.
//  Copyright © 2019 Ahmad Karkouti. All rights reserved.
//

import UIKit

class EventController: UITableViewController {
    
    let backgroundImage: UIImage = {
       let image = UIImage()
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        return cell
    }
    
    
    
}
