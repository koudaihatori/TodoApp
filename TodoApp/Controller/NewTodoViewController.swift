import UIKit

class NewTodoViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var todoField: UITextField!
    @IBOutlet weak var descriptionView: UITextView!
    @IBOutlet weak var prioritySegment: UISegmentedControl!
    let todoCollection = TodoCollection.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionView.layer.cornerRadius = 3
        descriptionView.layer.borderColor = UIColor(red: 0.9,
                                                    green: 0.9,
                                                    blue: 0.9,
                                                    alpha: 1).cgColor
        descriptionView.layer.borderWidth = 1
        
        let tapRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(NewTodoViewController.tapGesture(_:))
        )
        self.view.addGestureRecognizer(tapRecognizer)
        todoField.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        self.navigationController!.navigationBar.tintColor = UIColor.white
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "閉じる",
            style: UIBarButtonItemStyle.plain,
            target: self,
            action: #selector(NewTodoViewController.close)
        )
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "保存",
            style: UIBarButtonItemStyle.plain,
            target: self,
            action: #selector(NewTodoViewController.save)
        )
    }
    
    @objc func close(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func save(){
        if todoField.text!.isEmpty {
            //アラートの処理
            let alertView = UIAlertController(
                title: "エラー",
                message: "Todoが記述されていません",
                preferredStyle: UIAlertControllerStyle.alert)
            alertView.addAction(UIAlertAction(
                title: "はい",
                style: UIAlertActionStyle.default,
                handler: nil)
            )
            self.present(
                alertView,
                animated: true,
                completion: nil
            )
        } else {
            let todo = Todo()
            todo.title = todoField.text!
            todo.descript = descriptionView.text
            todo.priority = TodoPriority(rawValue: prioritySegment.selectedSegmentIndex)!
            
            self.todoCollection.addTodoCollection(todo: todo)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func tapGesture(_ sender: UITapGestureRecognizer){
        todoField.resignFirstResponder()
        descriptionView.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        todoField.resignFirstResponder()
        return true
    }
    
}
