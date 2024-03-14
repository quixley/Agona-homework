//
//  StartViewController.swift
//  AgonaHomework
//
//  Created by Artur on 07.03.2024.
//

import Foundation
import UIKit
import SnapKit

class StartViewController: UIViewController {
    
    private var people: [Person] = []

    private var tableView: UITableView = UITableView(frame: .zero, style: .grouped)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        print("Did show")
        view.addSubview(tableView)
        tableView.register(PersonTableViewCell.self, forCellReuseIdentifier: "Person")
        tableView.estimatedRowHeight = 50
        tableView.isHidden = true
        tableView.rowHeight = UITableView.automaticDimension
        tableView.dataSource = self
        tableView.delegate = self
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        fetchData()
    }

    private func fetchData() {
        guard let url = URL(string: "https://65e9dd62c9bf92ae3d3a7959.mockapi.io/api/get-people") else {
            return
        }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, _ in
            guard let data, let self else { return }
            handleResponse(with: data)
        }
        task.resume()
    }
    
    private func handleResponse(with data: Data) {
        let people = try? JSONDecoder().decode([Person].self, from: data)
        self.people = people ?? []
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension StartViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        people.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Person", for: indexPath) as? PersonTableViewCell else { return .init() }
        cell.configure(with: people[indexPath.row])
        return cell
    }

}
