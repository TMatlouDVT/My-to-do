//
//  ViewController.swift
//  My to-do
//
//  Created by Garlic Technologies  on 2017/07/10.
//  Copyright © 2017 Garlic Technologies . All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let menu: UIButton = {
        
        
        let mn = UIButton()
        mn.translatesAutoresizingMaskIntoConstraints = false
        mn.backgroundColor = .clear
        let image = UIImage(named: "menu")?.withRenderingMode(.alwaysTemplate)
        mn.setImage(image, for: UIControlState.normal)
        mn.tintColor = .white
        mn.addTarget(self, action: #selector(callSlideMenu), for: .touchUpInside)
        
        return mn
    }()
    
    let slideMenuUpDown: UIView = {
        
        let sm = UIView()
        sm.translatesAutoresizingMaskIntoConstraints = false
        sm.backgroundColor = .black
        sm.alpha = 0.8
        
        
        
        return sm
    }()
    
    let slideMenu: UIView = {
        
        let sm = UIView()
        sm.translatesAutoresizingMaskIntoConstraints = false
        sm.backgroundColor = .white
        sm.alpha = 1
        
        
        
        return sm
    }()
    
    let popular: UIButton = {
        
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 8
        btn.setTitle("Add a To Do", for: UIControlState.normal)
        btn.setTitleColor(UIColor.black, for: UIControlState.normal)
        btn.backgroundColor = .clear
        
        btn.addTarget(self, action: #selector(openPopular), for: .touchUpInside)
        
        return btn
    }()
    
    let goodMorning: UILabel = {
    
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .white
        lbl.textAlignment = NSTextAlignment.center
        lbl.text = "Good Morning !"
        lbl.font = UIFont(name:"HelveticaNeue", size: 24.0)
        
        return lbl
    }()
    
    let dayLabel: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .white
        lbl.textAlignment = NSTextAlignment.center
        lbl.font = UIFont(name:"HelveticaNeue", size: 37.0)
        lbl.backgroundColor = UIColor.init(red: 18/255, green: 147/255, blue: 243/255, alpha: 1)
        lbl.layer.cornerRadius = 49
        lbl.layer.masksToBounds = true
        
        
        return lbl
    }()
    
    let dayOfWeekLabel: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .white
        lbl.textAlignment = NSTextAlignment.center
        lbl.font = UIFont(name:"HelveticaNeue", size: 17.0)
        
        return lbl
    }()
    
    
    let monthLabel: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .white
        lbl.textAlignment = NSTextAlignment.center
        lbl.font = UIFont(name:"HelveticaNeue", size: 21.0)
        
        return lbl
    }()
    

    let underliner: UIView = {
    
        let uL = UIView()
        uL.translatesAutoresizingMaskIntoConstraints = false
        uL.backgroundColor = .white
        
        return uL
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        setup()
        getCurrentTime()
        
    }

    var topAnchor: NSLayoutConstraint?
    var rightAnchor: NSLayoutConstraint?
    func setup(){
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        
        UIImage(named: "swoosh")?.draw(in: self.view.bounds)
        
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        
        self.view.backgroundColor = UIColor(patternImage: image)
        
        view.addSubview(goodMorning)
        view.addSubview(dayLabel)
        view.addSubview(dayOfWeekLabel)
        view.addSubview(monthLabel)
        view.addSubview(menu)
        view.addSubview(underliner)
        view.addSubview(slideMenuUpDown)
        view.addSubview(slideMenu)
        slideMenu.addSubview(popular)
        
        goodMorning.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        goodMorning.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -165).isActive = true
        goodMorning.widthAnchor.constraint(equalToConstant: view.frame.width - 125).isActive = true
        goodMorning.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
        dayLabel.topAnchor.constraint(equalTo: goodMorning.bottomAnchor, constant: 5).isActive = true
        dayLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        dayLabel.widthAnchor.constraint(equalToConstant: 95).isActive = true
        dayLabel.heightAnchor.constraint(equalToConstant: 95).isActive = true
        
        dayOfWeekLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        dayOfWeekLabel.topAnchor.constraint(equalTo: dayLabel.bottomAnchor, constant: -30).isActive = true
        dayOfWeekLabel.heightAnchor.constraint(equalToConstant: 35).isActive = true
        dayOfWeekLabel.widthAnchor.constraint(equalToConstant: view.frame.width / 2).isActive = true
        
        monthLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        monthLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        monthLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -1).isActive = true
        monthLabel.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
        menu.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        menu.topAnchor.constraint(equalTo: view.topAnchor, constant: 25).isActive = true
        menu.heightAnchor.constraint(equalToConstant: 25).isActive = true
        menu.widthAnchor.constraint(equalToConstant: 25).isActive = true
        
        underliner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        underliner.topAnchor.constraint(equalTo: monthLabel.bottomAnchor, constant: -1).isActive = true
        underliner.widthAnchor.constraint(equalToConstant: view.frame.width / 2).isActive = true
        underliner.heightAnchor.constraint(equalToConstant: 2).isActive = true
        
        slideMenuUpDown.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        slideMenuUpDown.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        slideMenuUpDown.heightAnchor.constraint(equalToConstant: view.frame.height).isActive = true
        topAnchor = slideMenuUpDown.topAnchor.constraint(equalTo: view.bottomAnchor)
        topAnchor?.isActive = true
        
        slideMenu.topAnchor.constraint(equalTo: menu.bottomAnchor, constant: 5).isActive = true
        slideMenu.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        slideMenu.widthAnchor.constraint(equalToConstant: view.frame.width / 2).isActive = true
        rightAnchor = slideMenu.rightAnchor.constraint(equalTo: view.leftAnchor)
        rightAnchor?.isActive = true
        
        popular.rightAnchor.constraint(equalTo: slideMenu.rightAnchor, constant: -5).isActive = true
        popular.topAnchor.constraint(equalTo: slideMenu.topAnchor, constant: 15).isActive = true
        popular.heightAnchor.constraint(equalToConstant: 35).isActive = true
        popular.widthAnchor.constraint(equalToConstant: 125).isActive = true

        
    }
    
    var dayOfWeek: String!
    var month: String!
    
    func getCurrentTime(){
        
        let date = Date()
        let calender = Calendar.current
        
        
        let day = calender.component(.day, from: date)
        
        
        
        let dayOfWeekG = calender.component(.weekday, from: date)
        let monthG = calender.component(.month, from: date)
        
        switch dayOfWeekG {
        
        case 1 :
            
            let sun: String? = "Sun"
            

            dayOfWeek = sun!
       
            break
        
        case 2 :
    
            let mon: String? = "Mon"
            
            dayOfWeek = mon!
            
            break
        
        case 3 :
            
            let tue: String? = "Tue"
            
            dayOfWeek = tue!
            
            break
        
        case 4 :
            
            dayOfWeek = "Wed"
            
            break
        
        case 5 :
            
            dayOfWeek = "Thu"
            
            break
        
        case 6 :
            
            dayOfWeek = "Fri"
            
            break
        
        case 7 :
            
            dayOfWeek = "Sat"
            
            break
        
        default :
            
            dayOfWeek = "..."
            
            break
        
        }
        
        switch monthG {
            
        case 1 :
            
            month = "January"
            
            break
            
        case 2 :
            
            month = "February"
            
            break
            
        case 3 :
            
            month = "March"
            
            break
            
        case 4 :
            
            month = "April"
            
            break
            
        case 5 :
            
            month = "May"
            
            break
            
        case 6 :
            
            month = "June"
            
            break
            
        case 7 :
            
            month = "July"
            
            break
            
        case 8 :
            
            month = "August"
            
            break
            
            
        case 9 :
            
            month = "September"
            
            break
            
            
        case 10 :
            
            month = "October"
            
            break
            
            
        case 11 :
            
            month = "November"
            
            break
            
            
        case 12 :
            
            month = "December"
            
            
            break
            
        default :
            
            month = "..."
            
            break
            
        }
        
        let year = calender.component(.year, from: date)
        
        let hour = calender.component(.hour, from: date)
        
        if hour > 11 {
        
            goodMorning.text = "Good Afternoon!"
        
            
        }else{
       
            goodMorning.text = "Good Morning!"
        
        }
        
        dayLabel.text = "\(day)"
        dayOfWeekLabel.text = "\(dayOfWeek!)"
        monthLabel.text = "\(month!) \(year)"
        
    }
    
    var slideMenuWasCalled = false
    
    func slides(){
        
        if slideMenuWasCalled == false {
            
            topAnchor?.isActive = false
            topAnchor?.constant = -slideMenu.frame.height
            topAnchor?.isActive = true
            
            rightAnchor?.isActive = false
            rightAnchor?.constant = view.frame.width / 2
            rightAnchor?.isActive = true
            
            UIView.animate(withDuration: 0.9) {
                
                self.view.layoutIfNeeded()
                
            }
            
            slideMenuWasCalled = true
            let image = UIImage(named: "cancel")?.withRenderingMode(.alwaysTemplate)
            menu.setImage(image, for: UIControlState.normal)
            
        }else {
            
            topAnchor?.isActive = false
            topAnchor?.constant = 0
            topAnchor?.isActive = true
            
            rightAnchor?.isActive = false
            rightAnchor?.constant = 0
            rightAnchor?.isActive = true
            
            UIView.animate(withDuration: 0.9, animations: {
                
                self.view.layoutIfNeeded()
                
            })
            
            slideMenuWasCalled = false
            let image = UIImage(named: "menu")?.withRenderingMode(.alwaysTemplate)
            menu.setImage(image, for: UIControlState.normal)
        }
        
    }
    
    func callSlideMenu (){
        
        slides()
        
    }
    
    func openPopular(){
    
        let popularV = PopularViewController()
        
        let nav = UINavigationController(rootViewController: popularV)
        
        present(nav, animated: true, completion: nil)
    
        slides()
    
    }
    
    func signUpForToDo(){
    
    
        
    }
    

}

