//
//  EventController.swift
//  CultureAR
//
//  Created by Ahmad Karkouty on 3/18/19.
//  Copyright © 2019 Ahmad Karkouti. All rights reserved.
//

import UIKit

class EventController: UITableViewController {
    
    var passedTitle = ""
    var passedDescription = ""
    
    let backgroundImage: UIImage = {
       let image = UIImage()
        return image
    }()
    
    let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.frame = CGRect(x: 1, y: 50, width: view.frame.width, height: 300)
        return view
    }()
    
    var headerImage: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "1")
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(eventTitleCell.self, forCellReuseIdentifier: "Title")
        tableView.register(descriptionTitleCell.self, forCellReuseIdentifier: "Description")
        headerImage.fillSuperview(headerView)
        self.tableView.tableHeaderView = headerView
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Title", for: indexPath) as! eventTitleCell
            cell.titleLabel.text = passedTitle
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Description", for: indexPath) as! descriptionTitleCell
            cell.descriptionLabel.text = passedDescription
            return cell
        }

    }
    

    
}


class eventTitleCell: UITableViewCell {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        label.text = "hello"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        titleLabel.fillSuperview(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class descriptionTitleCell: UITableViewCell {
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        descriptionLabel.fillSuperview(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
