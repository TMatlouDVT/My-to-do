//
//  DidSelectViewController.swift
//  My to-do
//
//  Created by Garlic Technologies  on 2017/07/11.
//  Copyright © 2017 Garlic Technologies . All rights reserved.
//

import UIKit

class DidSelectViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {

    var popularCoreData: [Popular] = []
    var customCoreData: [Custom] = []
    
    var workCoreData: [Work] = []
    var foodCoreData: [Food] = []
    var homeCoreData: [Home] = []
    var autoCoreData: [Auto] = []
    
    var currentCell: String!
    var passedT: String!
    
    public func passTitle(title passedTitle: String){
    
        passedT = passedTitle

        if passedTitle == "work" || passedTitle == "food" || passedTitle == "home" || passedTitle == "auto" {
        
            currentCell = "Popular"
        
            getData()
        
        }else{
        
            currentCell = "Custom"
        
            getData()
        }
    
    }
    
    func getData(){
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do{
            
            popularCoreData = try context.fetch(Popular.fetchRequest())
            customCoreData = try context.fetch(Custom.fetchRequest())
            workCoreData = try context.fetch(Work.fetchRequest())
            foodCoreData = try context.fetch(Food.fetchRequest())
            homeCoreData = try context.fetch(Home.fetchRequest())
            autoCoreData = try context.fetch(Auto.fetchRequest())
            
            
        }catch {
            
            print("Fetching failed")
            
        }
        
    }
    
    
    let cellId = "didSelectCell"
    
    let topImage: UIImageView = {
        
        let bI = UIImageView()
        bI.translatesAutoresizingMaskIntoConstraints = false
        
        return bI
    }()
    
    let collectionView: UICollectionView = {
    
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(DidSelectCell.self, forCellWithReuseIdentifier: "didSelectCell")
        
        return collection
        
    }()
    
    let add: UIButton = {
    
    
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: "cancel")?.withRenderingMode(.alwaysTemplate)
        
        btn.setImage(image, for: UIControlState.normal)
        btn.tintColor = .white
        btn.backgroundColor = UIColor.init(red: 18/255, green: 147/255, blue: 243/255, alpha: 1)
        btn.layer.cornerRadius = 23
        btn.layer.masksToBounds = true
        
        btn.addTarget(self, action: #selector(addToDo), for: .touchUpInside)
        
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        setup()
        
        
        
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        collectionView.reloadData()
    }
    
    func setup(){
    
        view.addSubview(topImage)
        view.addSubview(collectionView)
        view.addSubview(add)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        topImage.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        topImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 35).isActive = true
        topImage.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        topImage.heightAnchor.constraint(equalToConstant: 225).isActive = true
        
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: topImage.bottomAnchor, constant: 35).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    
        add.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        add.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5).isActive = true
        add.heightAnchor.constraint(equalToConstant: 45).isActive = true
        add.widthAnchor.constraint(equalToConstant: 45).isActive = true
        
        add.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi) / 4)
    
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let pass = passedT {
        
        
        }
        
        if passedT == "work" {
        
            if workCoreData != [] {
            
            
                return workCoreData.count
                
            }else {
            
                
                return 0
            
            }
        
            
            
        }else if passedT == "food" {
        
        
            if foodCoreData != [] {
                
                
                return foodCoreData.count
                
                
            }else {
                
                
                return 0
                
            }

            
        
        
        }else if passedT == "home" {
        
        
            if homeCoreData != [] {
                
                
                return homeCoreData.count
                
                
            }else {
                
                
                return 0
                
            }
            
            
            
        
        }else if passedT == "auto" {
        
            
            if autoCoreData != [] {
                
                
                return autoCoreData.count
                
                
            }else {
                
                
                return 0
                
            }
            
        
        } else{
        
            if customCoreData != [] {
        
            return customCoreData.count
                
            } else {
            
            
                return 0
            }
        
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! DidSelectCell
        
        if passedT == "work" {
            
            
            cell.paragraph.text = workCoreData[indexPath.item].work
            
        }else if passedT == "food" {
            
            cell.paragraph.text = foodCoreData[indexPath.item].food
            
            
        }else if passedT == "home" {
            
            cell.paragraph.text = homeCoreData[indexPath.item].home
            
            
        }else if passedT == "auto" {
            
            cell.paragraph.text = autoCoreData[indexPath.item].auto
            
        } else{
            
            
           cell.paragraph.text = customCoreData[indexPath.item].custom
        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        let size = CGSize(width: view.frame.width, height: 85)
        
        return size
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        let moreView = ViewMoreViewController()
        
        moreView.getIndex(index: indexPath.item, pass: passedT)
        
        if passedT == "work" {
            
            moreView.setText(text: workCoreData[indexPath.item].work!)
            
        }else if passedT == "food" {
            
            
            moreView.setText(text: foodCoreData[indexPath.item].food!)
            
        }else if passedT == "home" {
            
            moreView.setText(text: homeCoreData[indexPath.item].home!)
            
        }else if passedT == "auto" {
            
            moreView.setText(text: autoCoreData[indexPath.item].auto!)
            
        } else{
            
            moreView.setText(text: customCoreData[indexPath.item].custom!)
            
        }
        
        navigationController?.pushViewController(moreView, animated: true)
        
        
    }
    
    var accText = UITextField()
    
    func addToDo(){
        
        let alert = UIAlertController(title: "\(passedT.uppercased())", message: "What would you like to do for \(passedT!)", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: self.okHandler))
        alert.addTextField(configurationHandler: accTextH)
        
        self.present(alert, animated: true, completion: nil)
        
        collectionView.reloadData()
    
    }
    
    func accTextH(textField: UITextField!){
        
        accText = textField
        accText.placeholder = "To do..."
        
    }
    
    func okHandler(alert: UIAlertAction!){
        
        print("Ok pressed")
        
        if accText.text != nil {
            
            if passedT == "work" {
                
                
                saveForWork(item: accText.text!)
                
            }else if passedT == "food" {
                
                saveForFood(item: accText.text!)
                
                
            }else if passedT == "home" {
                
                saveForHome(item: accText.text!)
                
                
            }else if passedT == "auto" {
                
                saveForAuto(item: accText.text!)
                
            } else{
                
                saveCustomItem(item: accText.text!)
               
            }
            
            
        }
        
        getData()
        collectionView.reloadData()
        
    }
    
    func saveForWork(item: String){
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let core = Work(context: context)
        
        core.work = item
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
    }
    
    func saveForFood(item: String){
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let core = Food(context: context)
        
        core.food = item
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
    }
    
    func saveForHome(item: String){
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let core = Home(context: context)
        
        core.home = item
        
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
    }
    
    func saveForAuto(item: String){
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let core = Auto(context: context)
        
        core.auto = item
        
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
    }
    
    func saveCustomItem(item: String){
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let cust = Custom(context: context)
        
        cust.custom = item
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
    }
    
}
