//
//  addVC.swift
//  Todo
//
//  Created by ShafiulAlam-00058 on 6/13/24.
//

import UIKit

class AddVC: UIViewController {

    
    @IBOutlet weak var textView: UITextField!
    
    var delegate: TodoDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = delegate.item?.name
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        delegate?.item = nil
        delegate?.index = nil
    }
    
    @IBAction func addData(_ sender: Any) {
        if((delegate.item) != nil) {
            delegate.updateTodos(data: textView.text ?? "")
        }
        else {
            delegate.saveTodos(data: textView.text ?? "", isCompleted: false)
        }
        self.dismiss(animated: true)
    }
}
