//
//  PopularCell.swift
//  My to-do
//
//  Created by Garlic Technologies  on 2017/07/10.
//  Copyright © 2017 Garlic Technologies . All rights reserved.
//

import UIKit

class PopularCell: UICollectionViewCell {

    
    
    let backgroundImage: UIImageView = {
    
        let bI = UIImageView()
        bI.translatesAutoresizingMaskIntoConstraints = false
        
        return bI
    }()
    
    let shadow: UIView = {
    
        let shad = UIView()
        shad.translatesAutoresizingMaskIntoConstraints = false
        shad.backgroundColor = .black
        shad.alpha = 0.6
        
        return shad
    }()
    
    let title: UILabel = {
    
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .white
        lbl.textAlignment = NSTextAlignment.left
        
        return lbl
    }()
    
    let numberOfTodos: UILabel = {
    
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .white
        lbl.layer.cornerRadius = 12
        lbl.layer.masksToBounds = true
        lbl.backgroundColor = .gray
        lbl.textAlignment = NSTextAlignment.center 
        
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    func setup(){
    
        addSubview(backgroundImage)
        addSubview(shadow)
        addSubview(title)
        addSubview(numberOfTodos)
        
        shadow.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        shadow.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        shadow.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        shadow.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        backgroundImage.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        backgroundImage.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        backgroundImage.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        backgroundImage.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        title.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true
        title.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        title.widthAnchor.constraint(equalToConstant: 65).isActive = true
        title.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        numberOfTodos.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        numberOfTodos.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        numberOfTodos.heightAnchor.constraint(equalToConstant: 35).isActive = true
        numberOfTodos.widthAnchor.constraint(equalToConstant: 35).isActive = true
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
