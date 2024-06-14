//
//  ViewController.swift
//  Todo
//
//  Created by ShafiulAlam-00058 on 6/11/24.
//

import UIKit

protocol TodoDelegate {
    var item: TodoList? { get set }
    func saveTodos(data: String, isCompleted: Bool)
    func updateTodos(data: String)
}

class ViewController: UIViewController, TodoDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var todos: [TodoList] = []
    var item: TodoList?
    var index: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.getTodos()
    }
    
    @IBAction func addButton(_ sender: Any) {
        performSegue(withIdentifier: "gotoHell", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoHell" {
            if let destination = segue.destination as? AddVC {
                destination.delegate = self
            }
        }
    }
    
    
}

// MARK: - Table Service
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") { _ , _ , _ in
            self.deleteTodos(index: indexPath.row)
        }
        let config = UISwipeActionsConfiguration(actions: [action])
        return config
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: "Update") { _, _, _ in
            self.sendDataForUpdate(index: indexPath.row)
        }
        action.backgroundColor = .systemYellow
        let config = UISwipeActionsConfiguration(actions: [action])
        return config
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TaskTVC {
            cell.taskNameLabel.text = todos[indexPath.row].name
            cell.taskDateLabel.text = todos[indexPath.row].date?.description
            cell.boxView.layer.borderWidth = 1
            if(todos[indexPath.row].isCompleted) {
                cell.checkImageView.image = UIImage(named: "check-mark")
            }
            else {
                cell.checkImageView.image = UIImage()
            }
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onTap(_:)))
            
            cell.boxView.addGestureRecognizer(tapGesture)
            
            return cell
        }
        else {
            return UITableViewCell()
        }
    }
    
    @objc func onTap(_ sender: UITapGestureRecognizer) {
        //        saveTodos(data: todos[indexPath.row].name ?? "", isCompleted: true)
        let location = sender.location(in: tableView)
        
        // Get the corresponding indexPath
        if let indexPath = tableView.indexPathForRow(at: location) {
            updateTick(index: indexPath.row)
        }
    }
}

// MARK: - Core Data Service
extension ViewController {
    func saveTodos(data: String, isCompleted: Bool = false) {
        if(data != "") {
            let task = TodoList(context: context)
            task.name = data
            task.date = Date()
            task.isCompleted = isCompleted
            
            do{
                try context.save()
                todos.append(task)
                tableView.reloadData()
            }
            catch {
                print(error)
            }
        }
    }
    
    func getTodos() {
        do {
            todos = try context.fetch(TodoList.fetchRequest())
            tableView.reloadData()
        }
        catch {
            print(error)
        }
    }
    
    func updateTick(index: Int) {
        let item = todos[index]
        item.isCompleted = !item.isCompleted
        do {
            try context.save()
            tableView.reloadData()
        }
        catch {
            print(error)
        }
    }
    
    func sendDataForUpdate(index: Int) {
        self.item = todos[index]
        self.index = index
        performSegue(withIdentifier: "gotoHell", sender: self)
        self.item = nil
        self.index = nil
    }
    
    func updateTodos(data: String) {
        let item = todos[self.index]
        item.name = data
        do {
            try context.save()
            tableView.reloadData()
        }
        catch {
            print(error)
        }
    }
    
    func deleteTodos(index: Int) {
        let item = todos[index]
        context.delete(item)
        do {
            try context.save()
            todos.remove(at: index)
            tableView.reloadData()
        }
        catch {
            print(error)
        }
    }
}

