//
//  iTunesSearchVC+Extension.swift
//  ProgrammaticUI
//
//  Created by Apple on 18/08/20.
//  Copyright © 2020 Somendra Yadav. All rights reserved.
//

import UIKit
import SDWebImage

//MARK: - iTunesSearchVC TableView Delagate(s)
/*
 * didSelectRowAt(s) by UITableViewDelegate to implement cell selection action(s)
 *
 * didHighlightRowAt to implement cell selection Highlights(s)
 *
 * didUnhighlightRowAt to implement cell selection UnHighlights(s)
 *
 */
extension iTunesSearchVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = datasource.itemIdentifier(for: indexPath) else {return}
        self.showDetailHook(item)
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

//MARK: - iTunesSearchVC UISearchControlDelegate
/*
 * Setup updateSearchResults(s) by UISearchResultsUpdating Delegate
 *
 */
extension iTunesSearchVC: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text, !text.isEmpty else { return }
        cancellable?.cancel()
        let debouncedFunc = debounce(interval: 2000, queue: .main) {
            self.search(query: text)
        }
        debouncedFunc()
    }
}

//MARK: - iTunesSearchVC UI & Constraint func(s)
/*
 * Setup Constarint(s) by setUpConstraints()
 *
 * Setup UI(s) by setUpUI()
 *
 */
extension iTunesSearchVC {
    
    //MARK: - setUpConstraints(s)
    func setUpConstraints() {
        self.tbliTunes.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        self.loader.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    //MARK: - setUpUI(s)
    func setUpUI() {
        self.tbliTunes.delegate   = self
        self.setDataSource()
        
        self.tbliTunes.backgroundColor    = .clear
        self.tbliTunes.estimatedRowHeight = UITableView.automaticDimension
        self.tbliTunes.register(iTunessongTableViewCell.self)

        self.view.addSubview(tbliTunes)
        self.view.addSubview(self.loader)
        
        self.setUpConstraints()
        
        self.tbliTunes.separatorStyle = .none
        view.backgroundColor = .secondarySystemBackground
    }
    
     //MARK: - setDataSource()
    func setDataSource() {
        datasource = UITableViewDiffableDataSource<Section,Result>(tableView: tbliTunes, cellProvider: { (tableView, indexPath, item) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(ofType: iTunessongTableViewCell.self, for: indexPath)
            cell.configCellWithModel(item)
            cell.selectionStyle = .none
            return cell
        })
    }
}
