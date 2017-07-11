//
//  DidSelectCell.swift
//  My to-do
//
//  Created by Garlic Technologies  on 2017/07/11.
//  Copyright © 2017 Garlic Technologies . All rights reserved.
//

import UIKit

class DidSelectCell: UICollectionViewCell {

    var collectionView = DidSelectViewController()
    
    let paragraph: UILabel = {
    
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .white
        lbl.textAlignment = NSTextAlignment.left
        lbl.backgroundColor = .gray
        lbl.numberOfLines = 5
        
        return lbl
    
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        setup()
        
    }
    
    func setup(){
    
        addSubview(paragraph)
        
        paragraph.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        paragraph.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        paragraph.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        paragraph.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    
        
    }
    
   
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
