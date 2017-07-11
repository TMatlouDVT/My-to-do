//
//  PopularViewController.swift
//  My to-do
//
//  Created by Garlic Technologies  on 2017/07/10.
//  Copyright © 2017 Garlic Technologies . All rights reserved.
//

import UIKit
import CoreData

class PopularViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {

    var popularCoreData: [Popular] = []
    var customCoreData: [Custom] = []
    
    public func currentPage(current getCurrent: String){
    
        currentCell = getCurrent
        
        bottomSliderLeftAnchor?.isActive = false
        bottomSliderLeftAnchor?.constant = view.frame.width / 2 - 5
        bottomSliderLeftAnchor?.isActive = true
        
        UIView.animate(withDuration: 0.4) {
            
            
            self.view.layoutIfNeeded()
            
        }
    }
    
    var workCoreData: [Work] = []
    var foodCoreData: [Food] = []
    var homeCoreData: [Home] = []
    var autoCoreData: [Auto] = []
    
    var datas: [[NSManagedObject]] = []
    
    let cellId = "cellId"
    
    let customCellId = "customCellId"
    
    let images: [String] = ["work", "food", "home", "auto"]
    
    let titles: [String] = ["Work", "Food", "Home", "Auto"]
    
    let titlesForCoreData: [String] = ["work", "food", "home", "auto"]
   
    
    let topContainer: UIView = {
    
        let tC = UIView()
        tC.translatesAutoresizingMaskIntoConstraints = false
        tC.backgroundColor = UIColor.init(red: 18/255, green: 147/255, blue: 243/255, alpha: 1)
        
        return tC
    }()
    
    let popular: UIButton = {
    
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Popular", for: UIControlState.normal)
        btn.setTitleColor(UIColor.white, for: UIControlState.normal)
        btn.addTarget(self, action: #selector(openPopular), for: .touchUpInside)
        
        return btn
    }()
    
    let custom: UIButton = {
        
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Custom", for: UIControlState.normal)
        btn.setTitleColor(UIColor.white, for: UIControlState.normal)
        btn.addTarget(self, action: #selector(openCustom), for: .touchUpInside)
        
        return btn
    }()

    let bottomSlider: UIView = {
    
        let btmSld = UIView()
        btmSld.translatesAutoresizingMaskIntoConstraints = false
        btmSld.backgroundColor = .white
        
        
        return btmSld
    }()
    
    
    let collection: UICollectionView = {
    
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let coll = UICollectionView(frame: .zero, collectionViewLayout: layout)
        coll.translatesAutoresizingMaskIntoConstraints = false
        coll.register(PopularCell.self, forCellWithReuseIdentifier: "cellId")
        coll.register(CustomCell.self, forCellWithReuseIdentifier: "customCellId")
        
        return coll
    }()
    
    let home: UIButton = {
    
        let hme = UIButton()
        hme.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: "home-1")
        hme.setImage(image, for: UIControlState.normal)
        hme.addTarget(self, action: #selector(openHome), for: .touchUpInside)
        hme.layer.cornerRadius = 32
        hme.layer.masksToBounds = true
        hme.backgroundColor = UIColor.init(red: 18/255, green: 147/255, blue: 243/255, alpha: 1)
        
        return hme
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getData()
        setup()
        
        datas = [workCoreData, foodCoreData, homeCoreData, autoCoreData]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        getData()
        collection.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getData()
        collection.reloadData()
    }
    
    var bottomSliderLeftAnchor: NSLayoutConstraint?

    func setup(){
    
    
        view.addSubview(topContainer)
        
        navigationItem.title = "Popular"
        
        
        topContainer.addSubview(popular)
        topContainer.addSubview(custom)
        topContainer.addSubview(bottomSlider)
        
        view.addSubview(collection)
        collection.delegate = self
        collection.dataSource = self
        
        view.addSubview(home)
        
        topContainer.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        topContainer.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        topContainer.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        topContainer.heightAnchor.constraint(equalToConstant: 65).isActive = true
    
        popular.leftAnchor.constraint(equalTo: topContainer.leftAnchor, constant: 5).isActive = true
        popular.topAnchor.constraint(equalTo: topContainer.topAnchor).isActive = true
        popular.widthAnchor.constraint(equalToConstant: view.frame.width / 2 - 5).isActive = true
        popular.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
        custom.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5).isActive = true
        custom.topAnchor.constraint(equalTo: topContainer.topAnchor).isActive = true
        custom.widthAnchor.constraint(equalToConstant: view.frame.width / 2 - 5).isActive = true
        custom.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
        bottomSlider.widthAnchor.constraint(equalToConstant: view.frame.width / 2 - 5).isActive = true
        bottomSlider.heightAnchor.constraint(equalToConstant: 2).isActive = true
        
        bottomSlider.bottomAnchor.constraint(equalTo: topContainer.bottomAnchor, constant: -3).isActive = true
        
        bottomSliderLeftAnchor = bottomSlider.leftAnchor.constraint(equalTo: popular.leftAnchor)
        bottomSliderLeftAnchor?.isActive = true
        
        
        collection.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collection.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collection.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collection.topAnchor.constraint(equalTo: topContainer.bottomAnchor).isActive = true
        
        home.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5).isActive = true
        home.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        home.widthAnchor.constraint(equalToConstant: 65).isActive = true
        home.heightAnchor.constraint(equalToConstant: 64).isActive = true
    
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        
        return 1
    }
    
    var customHasAtleastOne = false
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if currentCell == "Popular" {
        
        return titles.count
            
        }else {
        
            if customCoreData != [] {
            
           
                return 1
                
                
            }else {
            
                return 1
      
            }
        
        }
    }
    
    var currentCell = "Popular"
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if currentCell == "Popular" {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PopularCell
        
        cell.backgroundImage.image = UIImage(named: images[indexPath.item])
        
        cell.title.text = titles[indexPath.item]
        
        cell.numberOfTodos.text = "\(datas[indexPath.item].count)"
        
        return cell
        
            
        }else {
        
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: customCellId, for: indexPath) as! CustomCell
            
            cell.backgroundImage.image = UIImage(named: "background")
            
            cell.title.text = "More"
            
            cell.numberOfTodos.text = "\(customCoreData.count)"
           
            return cell
        
        
        
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if currentCell == "Popular" {
        
            let didS = DidSelectViewController()
            didS.topImage.image = UIImage(named: images[indexPath.item])
            didS.passTitle(title: titlesForCoreData[indexPath.item])
            
            /*let didS = FavouritesTableViewController()
            didS.passTitle(title: titlesForCoreData[indexPath.item], imageName: images[indexPath.item])*/
            
            //let nav = UINavigationController(rootViewController: didS)
            
            navigationController?.pushViewController(didS, animated: true)
            
            
        }else{
        
            let didS = DidSelectViewController()
            didS.passTitle(title: "Custom")
            didS.topImage.image = UIImage(named: "background")
            
            navigationController?.pushViewController(didS, animated: true)
        
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        let size = CGSize(width: view.frame.width, height: 195)
        
        return size
    }
    
    func openPopular(){
    
        
        bottomSliderLeftAnchor?.isActive = false
        bottomSliderLeftAnchor?.constant = 0
        bottomSliderLeftAnchor?.isActive = true
        
        UIView.animate(withDuration: 0.6) {
            
            
            self.view.layoutIfNeeded()
            
        }
        
        currentCell = "Popular"
        navigationItem.title = "Popular"
        collection.reloadData()
    
    }
    
    
    func openCustom(){
    
        
        bottomSliderLeftAnchor?.isActive = false
        bottomSliderLeftAnchor?.constant = view.frame.width / 2 - 5
        bottomSliderLeftAnchor?.isActive = true
        
        UIView.animate(withDuration: 0.6) {
            
            
            self.view.layoutIfNeeded()
            
        }
        
        currentCell = "Custom"
        navigationItem.title = "Custom"
        collection.reloadData()
        
        
    }
    
    func openHome(){
    
    
        self.dismiss(animated: true, completion: nil)
    
    }
    
    func getData(){
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do{
            
            customCoreData = try context.fetch(Custom.fetchRequest())
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
