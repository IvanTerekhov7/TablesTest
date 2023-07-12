//
//  ViewController.swift
//  TablesTest
//
//  Created by Ivan Terekhov on 08.06.2023.
//

import UIKit

class ViewController: UIViewController {

    private var dataSource = [
        "Vanya",
        "Aspiring",
        "Developer",
        "25YO"
    ]

    @IBOutlet private weak var namesTableView: UITableView!

    override func viewDidLoad() {
        // Inheritance by default allows for calling superclass methods
        // `super.viewDidLoad` means simply "call  method from the ancestor"
        super.viewDidLoad()
        setupTableView()
    }

    @IBAction private func addItemTapped(_ sender: Any) {
        let alert = makeAlert("Insert string")
        alert.addTextField()

        let insertNewItemAction = UIAlertAction(title: "Submit", style: .default) { [unowned alert] _ in
            guard let newItem = alert.textFields?.first?.text else {
                return
            }
            self.dataSource.append(newItem)
            self.namesTableView.reloadData()
        }
        alert.addAction(insertNewItemAction)

        present(alert, animated: true, completion: nil)
    }

    private func showAlert(_ title: String) {
        let alert = makeAlert(title)

        /// Another Variant of syntactic initialization breakdown by line
        let action = UIAlertAction(title: "OK",
                                   style: .default,
                                   handler: nil)
        alert.addAction(action)

        present(alert, animated: true, completion: nil)
    }

    /// We refactored alert creation not to repeat the same code multiple times
    private func makeAlert(_ title: String) -> UIAlertController {
        // Variant of syntactic initialization breakdown by line
        // If a body of a returning function contains only one statement, `return` can be omitted
        // Here we calling UIAlertController initializer to create an instance
        // Calling initializer = one statement
        UIAlertController(
            title: title,
            message: nil,
            preferredStyle: .alert
        )
    }

    private func setupTableView() {
        namesTableView.register(
            UINib(
                nibName: "PersonInfoTableViewCell",
                bundle: nil
            ),
            forCellReuseIdentifier: "PersonInfoTableViewCell"
        )
        namesTableView.dataSource = self
        namesTableView.delegate = self
    }
}

extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "PersonInfoTableViewCell",
            for: indexPath
        ) as? PersonInfoTableViewCell else {
            return UITableViewCell()
        }

        cell.translatesAutoresizingMaskIntoConstraints = false
        cell.contentLabel.text = dataSource[indexPath.row]

        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            dataSource.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

extension ViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        showAlert(dataSource[indexPath.row])
    }
}
