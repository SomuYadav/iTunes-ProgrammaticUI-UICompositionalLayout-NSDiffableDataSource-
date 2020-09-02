//
//  iTunesHome+Delegate+Extension.swift
//  ProgrammaticUI
//
//  Created by Apple on 22/08/20.
//  Copyright © 2020 Somendra Yadav. All rights reserved.
//

import UIKit

//MARK: - iTunesSearchVC TableView Delagate(s)
/**
 * didSelectRowAt(s) by UITableViewDelegate to implement cell selection action(s)
 *
 * didHighlightRowAt to implement cell selection Highlights(s)
 *
 * didUnhighlightRowAt to implement cell selection UnHighlights(s)
 *
 */
extension iTunesHomeVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let itunesDetailVC = iTunesDetailVC()
        itunesDetailVC.type = .saved(persistModel[indexPath.row])
        self.navigationController?.pushViewController(itunesDetailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else {return}
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 8, options: .curveEaseInOut, animations: {
            cell.transform = .init(scaleX: 0.9, y: 0.9)
        }, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else {
            return
        }
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: .curveEaseInOut, animations: {
            cell.transform = .identity
        }, completion: nil)
    }
}

//MARK: - iTunesSearchVC UI & Constarint func(s)
extension iTunesHomeVC {

     //MARK: - setUpConstraints(s)
    func setUpConstraints() {
        self.tbliTunes.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    //MARK: - setUpUI(s)
    func setUpUI() {
        self.tbliTunes.delegate   = self
        datasource = MyDataSource(tableView: tbliTunes, cellProvider: { (tableView, indexPath, item) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(ofType: iTunesUserTableViewCell.self, for: indexPath)
            cell.configCellWithModel(item)
            cell.selectionStyle = .none
            return cell
        })
    
        self.tbliTunes.backgroundColor    = .clear
        self.tbliTunes.estimatedRowHeight = UITableView.automaticDimension
        self.tbliTunes.register(iTunesUserTableViewCell.self)

        self.view.addSubview(tbliTunes)
        self.setUpConstraints()
        self.tbliTunes.separatorStyle = .none
        view.backgroundColor = .secondarySystemBackground
        self.setEmptyText()
    }
    
    //MARK: - setUpEmptyLabel()
    func setEmptyText() {
        self.emptyTxt  = UILabel()
        emptyTxt.font = UIFont.preferredFont(forTextStyle: .title3)
        emptyTxt.text = "Search users, go to detail page and saved it. user will appear here!"
        emptyTxt.sizeToFit()
        emptyTxt.textAlignment = .center
        emptyTxt.textColor     = .label
        emptyTxt.numberOfLines = 0
        self.tbliTunes.backgroundView = emptyTxt
    }
}

//MARK: - UITableViewDiffableDataSource<ViewController.Section,Model>
/**
 * titleForHeaderInSection will return header title
 *
 */
class MyDataSource: UITableViewDiffableDataSource<iTunesHomeVC.Section,Result> {
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Saved Search"
    }
}
