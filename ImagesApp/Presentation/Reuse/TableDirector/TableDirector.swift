//
//  TableDirector.swift
//  TableInteraction
//
//  Created by Zafar Ivaev on 04/09/22.
//

import UIKit

public final class TableDirector: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    public weak var tableView: UITableView?
    public var sections: [TableSection] = [] {
        didSet {
            let allRowModels = sections.flatMap { $0.rowModels }
            let allHeaderModels = sections.compactMap { $0.headerModel }
            
            allRowModels.forEach { rowModel in
                registerCell(identifier: rowModel.identifier)
            }
            
            allHeaderModels.forEach { headerModel in
                registerHeader(identifier: headerModel.identifier)
            }
            tableView?.reloadData()
        }
    }
    
    public var onCellSelection: ((IndexPath) -> ())?
    public var onCellWillDisplay: ((IndexPath, UITableViewCell) -> ())?

    public init(tableView: UITableView) {
        self.tableView = tableView
        super.init()
        self.tableView?.dataSource = self
        self.tableView?.delegate = self
    }
    
    // MARK: - Helper methods
    
    private func classFromString(_ className: String) -> AnyClass? {
        let namespace = Bundle.main.infoDictionary![
            "CFBundleExecutable"
        ] as! String
        let className: AnyClass? = NSClassFromString("\(namespace).\(className)")
        return className
    }
    
    private func registerCell(identifier: String) {
        if Bundle(for: Self.self).path(
            forResource: identifier,
            ofType: "nib"
        ) != nil {
            tableView?.register(
                UINib(
                    nibName: identifier,
                    bundle: Bundle(for: Self.self)
                ),
                forCellReuseIdentifier: identifier
            )
        } else {
            tableView?.register(
                classFromString(identifier),
                forCellReuseIdentifier: identifier
            )
        }
    }
    
    private func registerHeader(identifier: String) {
        if Bundle(for: Self.self).path(
            forResource: identifier,
            ofType: "nib"
        ) != nil {
            tableView?.register(
                UINib(
                    nibName: identifier,
                    bundle: .main
                ),
                forHeaderFooterViewReuseIdentifier: identifier
            )
        } else {
            tableView?.register(
                classFromString(identifier),
                forHeaderFooterViewReuseIdentifier: identifier
            )
        }
    }
    
    // MARK: - Data Source methods
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].rowModels.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sections[indexPath.section]
        let rowModel = section.rowModels[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: rowModel.identifier,
            for: indexPath
        ) as? BaseTableViewCell else {
            fatalError("Incorrectly configured cell")
        }
        cell.setup(with: rowModel)
        return cell
    }
    
    // MARK: - Delegate methods
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onCellSelection?(indexPath)
        if let onSelection = sections[indexPath.section]
            .rowModels[indexPath.row]
            .onSelection {
            onSelection()
        }
    }
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        onCellWillDisplay?(indexPath, cell)
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard
            let headerModel = sections[section].headerModel
        else {
            return nil
        }
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerModel.identifier) as? BaseHeaderFooterView else {
            return nil
        }
        headerView.setup(with: headerModel)
        return headerView
    }
    
    public func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let header = view as? UITableViewHeaderFooterView {
            if #available(iOS 14.0, *) {
                header.backgroundConfiguration = .listPlainHeaderFooter()
                header.backgroundConfiguration?.backgroundColor = .white
            } else {
                header.backgroundColor = .white
            }
        }
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if sections[section].headerModel != nil {
            return UITableView.automaticDimension
        }
        return 1
    }
}
