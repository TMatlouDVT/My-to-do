//
//  FavouritesCell.swift
//  Galaxy
//
//  Created by Garlic Technologies  on 2017/07/09.
//  Copyright © 2017 Garlic Technologies . All rights reserved.
//

import UIKit

class FavouritesCell: UITableViewCell {
    
    var tableViewController: FavouritesTableViewController?
    
    let city: UILabel = {
        
        let cty = UILabel()
        cty.translatesAutoresizingMaskIntoConstraints = false
        cty.textColor = .black
        
        return cty
    }()
    
    let delete: UIButton = {
        
        let dlt = UIButton()
        dlt.translatesAutoresizingMaskIntoConstraints = false
        dlt.setTitle("Delete", for: UIControlState.normal)
        dlt.setTitleColor(UIColor.red, for: UIControlState.normal)
        
        return dlt
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(){
        
        addSubview(city)
        addSubview(delete)
        
        city.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15).isActive = true
        city.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        city.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        city.widthAnchor.constraint(equalToConstant: 245).isActive = true
        
        delete.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15).isActive = true
        delete.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        delete.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        delete.widthAnchor.constraint(equalToConstant: 125).isActive = true
        
        delete.addTarget(self, action: #selector(deleteRow), for: .touchUpInside)
    }
    
    func deleteRow(){
        
        tableViewController?.deleteCell(cell: self)
        
    }
    
}
