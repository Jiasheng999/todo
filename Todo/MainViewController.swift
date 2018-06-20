//
//  ViewController.swift
//  Todo
//
//  Created by Tang Jiasheng on 2018/6/19.
//  Copyright © 2018 Jiasheng Tang. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var todoTableView: UITableView!
    @IBOutlet weak var topToolBar: UIView!
    @IBOutlet weak var bottomToolBar: UIView!
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var completedButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var addView: UIView!
    @IBOutlet weak var addViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var checkBox: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet var keyboardHeightLayoutConstraint: NSLayoutConstraint?
    
    var todos: [Todo]!
    var completedTodos: [Todo]!
    var currentPageIndex: Int = 2
    let beige = UIColor(red: 262/255, green: 247/255, blue: 236/255, alpha: 1)
//    var blurEffectView: UIVisualEffectView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todos = Todo.loadFromFile() ?? Todo.loadSampleData()
        
        // Load data if any
        completedTodos = []
        
        todoTableView.rowHeight = 70
        todoTableView.backgroundColor = beige
        topToolBar.backgroundColor = beige
        bottomToolBar.backgroundColor = beige
        
        filterButton.imageView?.image = filterButton.imageView?.image?.withRenderingMode(.alwaysTemplate)
        menuButton.imageView?.image = menuButton.imageView?.image?.withRenderingMode(.alwaysTemplate)
        completedButton.imageView?.image = completedButton.imageView?.image?.withRenderingMode(.alwaysTemplate)
        addButton.imageView?.image = addButton.imageView?.image?.withRenderingMode(.alwaysTemplate)
        
        filterButton.tintColor = UIColor.lightGray
        menuButton.tintColor = UIColor.black
        completedButton.tintColor = UIColor.lightGray
        addButton.tintColor = UIColor.black
        
        // Add view
        addView.backgroundColor = beige
        
        // Blur effect
//        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
//        blurEffectView = UIVisualEffectView(effect: blurEffect)
//        blurEffectView.frame = self.view.bounds
//        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        Todo.saveToFile(todos: todos)
    }
    
    override func viewDidLayoutSubviews() {
        let border = CALayer()
        let width = CGFloat(2.0)
        border.borderColor = UIColor.darkGray.cgColor
        border.frame = CGRect(x: 0, y: textField.frame.size.height - width, width:  textField.frame.size.width, height: textField.frame.size.height)
        
        border.borderWidth = width
        textField.layer.addSublayer(border)
        textField.layer.masksToBounds = true
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if currentPageIndex == 2 {
            return todos.count
        } else {
            return completedTodos.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath) as! TodoTableViewCell
        cell.backgroundColor = beige
        
        let todo: Todo?
        if currentPageIndex == 2 {
            todo = todos[indexPath.row]
            cell.checkBox.setImage(UIImage(named: "checkBox.png"), for: .normal)
        } else {
            todo = completedTodos[indexPath.row]
            cell.checkBox.setImage(UIImage(named: "checkedBox.png"), for: .normal)
        }
        
        if todo != nil {
            if todo?.tags == [] {
                cell.todoMainLabel.isHidden = false
                cell.todoSecondaryLabel.isHidden = true
                cell.tagImageView.isHidden = true
                cell.tagLabel.isHidden = true
                cell.todoMainLabel.text = todo?.content
            } else {
                cell.todoMainLabel.isHidden = true
                cell.todoSecondaryLabel.isHidden = false
                cell.tagImageView.isHidden = false
                cell.tagImageView.image = UIImage(named: "tag.png")
                cell.tagLabel.isHidden = false
                cell.tagLabel.text = todo?.tags.joined(separator: ", ")
                cell.tagLabel.textColor = UIColor.darkGray
                cell.todoSecondaryLabel.text = todo?.content
            }
        }
        return cell
    }
    
    @IBAction func checkBoxTapped(_ sender: UIButton) {
        ////////// NEED IMPROVING
        let cell = sender.superview?.superview as! TodoTableViewCell
        if let indexPath = todoTableView.indexPath(for: cell) {
            if currentPageIndex == 2 {
                var todo = todos[indexPath.row]
                todo.completion = 1
                todos.remove(at: indexPath.row)
                completedTodos.append(todo)
            } else if currentPageIndex == 3 {
                var todo = completedTodos[indexPath.row]
                todo.completion = 0
                completedTodos.remove(at: indexPath.row)
                todos.append(todo)
            }
        }
        todoTableView.reloadData()
    }
    
    
    @IBAction func filterButtonTapped(_ sender: UIButton) {
        filterButton.tintColor = UIColor.black
        menuButton.tintColor = UIColor.lightGray
        completedButton.tintColor = UIColor.lightGray
        currentPageIndex = 1
    }
    
    @IBAction func menuButtonTapped(_ sender: UIButton) {
        filterButton.tintColor = UIColor.lightGray
        menuButton.tintColor = UIColor.black
        completedButton.tintColor = UIColor.lightGray
        currentPageIndex = 2
        todoTableView.reloadData()
    }
    
    @IBAction func completedButtonTapped(_ sender: UIButton) {
        filterButton.tintColor = UIColor.lightGray
        menuButton.tintColor = UIColor.lightGray
        completedButton.tintColor = UIColor.black
        currentPageIndex = 3
        todoTableView.reloadData()
    }
    @IBAction func addButtonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3, animations: {
            self.addViewBottomConstraint.constant = -(self.keyboardHeightLayoutConstraint?.constant)!
            self.view.layoutIfNeeded()
        })
        textField.becomeFirstResponder()
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3, animations: {
            self.addViewBottomConstraint.constant = -self.addView.frame.height
            self.view.layoutIfNeeded()
            })
        
        
    }
    
}

