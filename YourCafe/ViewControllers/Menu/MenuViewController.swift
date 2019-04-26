//
//  MenuViewController.swift
//  YourCafe
//
//  Created by 이동건 on 21/04/2019.
//  Copyright © 2019 이동건. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var menuTitles: [String] = [
        "내가 좋아하는 카페",
        "내가 등록한 카페",
        "내가 남긴 글",
        "설정"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = .white
        tableView.backgroundColor = UIColor.dark
        registerCells()
    }
    
    private func registerCells() {
        tableView.register(UINib(nibName: MenuTableViewHeader.reuseIdentifier, bundle: nil), forHeaderFooterViewReuseIdentifier: MenuTableViewHeader.reuseIdentifier)
        tableView.register(UINib(nibName: MenuTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: MenuTableViewCell.reuseIdentifier)
    }
}

extension MenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        dismiss(animated: true, completion: nil)
    }
}

extension MenuViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuTableViewCell.reuseIdentifier, for: indexPath) as! MenuTableViewCell
        cell.configure(menuTitles[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: MenuTableViewHeader.reuseIdentifier) as! MenuTableViewHeader
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 261
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
