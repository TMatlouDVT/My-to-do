
import UIKit

class FavouritesTableViewController: UITableViewController {

    var popularCoreData: [Popular] = []
    var customCoreData: [Custom] = []
    
    var workCoreData: [Work] = []
    var foodCoreData: [Food] = []
    var homeCoreData: [Home] = []
    var autoCoreData: [Auto] = []
    
    var currentCell: String!
    var passedT: String!
    var passedImageName: String!
    
    public func passTitle(title passedTitle: String, imageName passedImage: String){
        
        passedT = passedTitle
        passedImageName = passedImage
        
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
    
    let add: UIButton = {
        
        
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: "cancel")?.withRenderingMode(.alwaysTemplate)
        
        btn.setImage(image, for: UIControlState.normal)
        btn.tintColor = .white
        btn.backgroundColor = UIColor.init(red: 18/255, green: 147/255, blue: 243/255, alpha: 1)
        btn.layer.cornerRadius = 32
        btn.layer.masksToBounds = true
        
        btn.addTarget(self, action: #selector(addToDo), for: .touchUpInside)
        
        return btn
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getData()
        setup()
    
        tableView.register(FavouritesCell.self, forCellReuseIdentifier: "reuseIdentifier")
        tableView.register(TheHeader.self, forHeaderFooterViewReuseIdentifier: "headerId")
        tableView.sectionHeaderHeight = 55
    
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
        
    }
    
    func setup(){
    
    
        view.addSubview(add)
        
        add.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        add.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5).isActive = true
        add.heightAnchor.constraint(equalToConstant: 65).isActive = true
        add.widthAnchor.constraint(equalToConstant: 65).isActive = true

    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
    
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
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

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! FavouritesCell
        
        if passedT == "work" {
            
            
            cell.city.text = workCoreData[indexPath.item].work
            
        }else if passedT == "food" {
            
            cell.city.text = foodCoreData[indexPath.item].food
            
            
        }else if passedT == "home" {
            
            cell.city.text = homeCoreData[indexPath.item].home
            
            
        }else if passedT == "auto" {
            
            cell.city.text = autoCoreData[indexPath.item].auto
            
        } else{
            
            
            cell.city.text = customCoreData[indexPath.item].custom
        }
        
        return cell
        
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
        
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            do{
                if passedT == "work" {
                    
                    context.delete(workCoreData[indexPath.item])
                    workCoreData.remove(at: indexPath.item)
                    
                    
                }else if passedT == "food" {
                    
                    context.delete(foodCoreData[indexPath.item])
                    foodCoreData.remove(at: indexPath.item)
                    
                    
                }else if passedT == "home" {
                    
                    context.delete(homeCoreData[indexPath.item])
                    homeCoreData.remove(at: indexPath.item)
                    
                }else if passedT == "auto" {
                    
                    context.delete(autoCoreData[indexPath.item])
                    autoCoreData.remove(at: indexPath.item)
                    
                }else {
                    
                    context.delete(customCoreData[indexPath.item])
                    customCoreData.remove(at: indexPath.item)
                    
                }
                
                
                
                do {
                    
                    try context.save()
                    
                }catch{
                    
                }
                
            }catch {
                
                print("Fetching failed")
                
            }
            
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            tableView.reloadData()
        }
        
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "headerId") as! TheHeader
        
        header.header.image = UIImage(named: passedImageName)
        
        
        
        return header
    }
    
    func deleteCell(cell: UITableViewCell){
    
        if let diP = tableView.indexPath(for: cell){
        
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            do{
                if passedT == "work" {
                    
                    context.delete(workCoreData[diP.item])
                    workCoreData.remove(at: diP.item)
                    
                    
                }else if passedT == "food" {
                    
                    context.delete(foodCoreData[diP.item])
                    foodCoreData.remove(at: diP.item)
                    
                    
                }else if passedT == "home" {
                    
                    context.delete(homeCoreData[diP.item])
                    homeCoreData.remove(at: diP.item)
                    
                }else if passedT == "auto" {
                    
                    context.delete(autoCoreData[diP.item])
                    autoCoreData.remove(at: diP.item)
                    
                }else {
                    
                    context.delete(customCoreData[diP.item])
                    customCoreData.remove(at: diP.item)
                    
                }
                
                
                
                do {
                    
                    try context.save()
                    
                }catch{
                    
                }
                
            }catch {
                
                print("Fetching failed")
                
            }
            
            
            tableView.deleteRows(at: [diP], with: .automatic)
            
            tableView.reloadData()            
        }
    }
    
    func letsDisimiss(){
    
        self.dismiss(animated: true, completion: nil)
        
    }

    
    var accText = UITextField()
    
    func addToDo(){
        
        if currentCell == "Popular" {
        
        let alert = UIAlertController(title: "\(passedT.uppercased())", message: "What would you like to do for \(passedT!)", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: self.okHandler))
        alert.addTextField(configurationHandler: accTextH)
        
        self.present(alert, animated: true, completion: nil)
            
        }else {
        
        
            let alert = UIAlertController(title: "Custom To do", message: "What would you like to do ?", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Add", style: .default, handler: self.okHandler))
            alert.addTextField(configurationHandler: accTextH)
            
            self.present(alert, animated: true, completion: nil)
        
        }
        
        tableView.reloadData()
        
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
        
        tableView.reloadData()
        
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

class TheHeader: UITableViewHeaderFooterView {

    var dismiss: FavouritesTableViewController!
    
    let header: UIImageView = {
    
        let hdr = UIImageView()
        hdr.translatesAutoresizingMaskIntoConstraints = false
        
        
        return hdr
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(){
    
        addSubview(header)
        
        header.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        header.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        header.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        header.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    
    }
    
    func openHome(){
        
    
        dismiss = FavouritesTableViewController()
        
        dismiss.letsDisimiss()
        
        print("Called")
    }
    
}
