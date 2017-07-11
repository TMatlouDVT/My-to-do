//
//  ViewMoreViewController.swift
//  My to-do
//
//  Created by Garlic Technologies  on 2017/07/11.
//  Copyright © 2017 Garlic Technologies . All rights reserved.
//

import UIKit

class ViewMoreViewController: UIViewController {

    var popularCoreData: [Popular] = []
    var customCoreData: [Custom] = []
    
    var workCoreData: [Work] = []
    var foodCoreData: [Food] = []
    var homeCoreData: [Home] = []
    var autoCoreData: [Auto] = []
    
    var atIndex: Int!
    var passedT: String!
    
    public func getIndex(index passedIndex: Int, pass passed: String){
    
        atIndex = passedIndex
        passedT = passed
        
        print(atIndex)
        print(passedT)
    
    }
    
    public func setText(text getText: String){
    
    
        text.text = getText
    
    }
    
    let text: UILabel = {
    
        let txt = UILabel()
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.textColor = .black
        txt.numberOfLines = 5
        txt.isUserInteractionEnabled = true
        txt.textAlignment = NSTextAlignment.center
        
        return txt
    }()
    
    let deleteTodo: UIButton = {
    
        let delTodo = UIButton()
        delTodo.translatesAutoresizingMaskIntoConstraints = false
        delTodo.setTitle("Delete", for: UIControlState.normal)
        delTodo.setTitleColor(UIColor.red, for: UIControlState.normal)
        delTodo.addTarget(self, action: #selector(delet), for: .touchUpInside)
        
        return delTodo
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        setup()
        getData()
        
    }

    
    func setup(){
    
        view.backgroundColor = .white
        view.addSubview(text)
        view.addSubview(deleteTodo)
        
        text.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        text.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        text.widthAnchor.constraint(equalToConstant: view.frame.width - 55).isActive = true
        text.heightAnchor.constraint(equalToConstant: view.frame.height / 2).isActive = true
        
        deleteTodo.topAnchor.constraint(equalTo: text.bottomAnchor).isActive = true
        deleteTodo.widthAnchor.constraint(equalToConstant: view.frame.width / 2).isActive = true
        deleteTodo.heightAnchor.constraint(equalToConstant: 65).isActive = true
        deleteTodo.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
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
    
    
    
    func delet(){
        
        let index = atIndex!
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do{
            if passedT == "work" {
                
                context.delete(workCoreData[index])
                workCoreData.remove(at: index)
                
                
            }else if passedT == "food" {
                
                context.delete(foodCoreData[index])
                foodCoreData.remove(at: index)
                
                
            }else if passedT == "home" {
                
                context.delete(homeCoreData[index])
                homeCoreData.remove(at: index)
                
            }else if passedT == "auto" {
                
                context.delete(autoCoreData[index])
                autoCoreData.remove(at: index)
                
            }else {
                
                context.delete(customCoreData[index])
                customCoreData.remove(at: index)
                
            }
            
            
            
            do {
                
                try context.save()
                
            }catch{
                
            }
            
        }catch {
            
            print("Fetching failed")
            
        }
        

        self.dismiss(animated: true, completion: nil)
        
        
    }


}
