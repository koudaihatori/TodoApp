 import UIKit
 
 class TodoListTableViewController: UITableViewController {
    
    let todoCollection = TodoCollection.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        todoCollection.fetchTodos()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        self.navigationController!.navigationBar.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "新規作成",
            style: UIBarButtonItemStyle.plain,
            target: self,
            action: #selector(TodoListTableViewController.newTodo)
        )
        self.tableView.reloadData()
    }
    @objc func newTodo(){
        self.performSegue(withIdentifier: "PresentNewTodoViewController", sender: self)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.todoCollection.todos.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "reuseIdentifier")
        
        let todo = self.todoCollection.todos[indexPath.row]
        cell.textLabel!.text = todo.title
        cell.detailTextLabel!.text = todo.descript
        cell.textLabel!.font = UIFont(name: "HirakakuProN-W3", size: 15)
        return cell
    }
    
 }
