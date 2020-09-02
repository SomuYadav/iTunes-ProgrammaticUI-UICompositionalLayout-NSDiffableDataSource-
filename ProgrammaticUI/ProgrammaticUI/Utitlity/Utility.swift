//
//  Utility.swift
//  ProgrammaticUI
//
//  Created by Apple on 19/08/20.
//  Copyright © 2020 Somendra Yadav. All rights reserved.
//

import UIKit

/// it takes a closure and perform that closure after a given particular time
/// - Parameters:
///   - interval: interval in millliseconds
///   - queue: in queue which closure should be executed
///   - action: it will give callBacl after completion
/// - Returns: Non-Void type closure
func debounce(interval: Int, queue: DispatchQueue, action: @escaping (() -> Void)) -> () -> Void {
    var lastFireTime = DispatchTime.now()
    let dispatchDelay = DispatchTimeInterval.milliseconds(interval)

    return {
        lastFireTime = DispatchTime.now()
        let dispatchTime: DispatchTime = DispatchTime.now() + dispatchDelay

        queue.asyncAfter(deadline: dispatchTime) {
            let when: DispatchTime = lastFireTime + dispatchDelay
            let now = DispatchTime.now()
            if now.rawValue >= when.rawValue {
                action()
            }
        }
    }
}

/// it is a vertical stack view like swift UI
class VStack: UIStackView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.axis    = .vertical
        self.distribution = .fillProportionally
        self.spacing = 5
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

/// it is using for the heading purpose
class Name: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.font = UIFont.preferredFont(forTextStyle: .headline)
        self.textColor = .label
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

/// it is using for the subheading purpose
class SubTitle: UILabel {
    override init(frame: CGRect) {
         super.init(frame: frame)
        self.font = UIFont.preferredFont(forTextStyle: .caption2)
         self.textColor = .gray
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIView {
    /// create an empty spacer view
    /// - Returns: return an spacer view
    static func spacer() -> UIView{
        let spacer = UIView(frame: .infinite)
        spacer.backgroundColor = .clear
        return spacer
    }
}

extension UIStackView {
    /// convineience function for adding views in stack frm array
    /// - Parameter views: it takes array of views
    func addSubViews(views: [UIView]) {
        views.forEach { self.addArrangedSubview($0) }
    }
}

// MARK: - Generic Methods
/// An protocol for providing resuse ids for view like UITableViewCell, UICollectionViewCell and Supllimentry Views
public protocol ReusableView {
    static var reusableIdentifier: String { get }
}

// default implementation of ReusableView for UICollectionReusableView
extension UICollectionReusableView {
    static var reuseIdentifier: String {
        String(describing: Self.self)
    }
}

// default implementation of ReusableView for UITableViewCell
extension UITableViewCell: ReusableView {
    public static var reusableIdentifier: String {
        String(describing: self)
    }
}

// MARK: - Generic Methods
extension UICollectionView {
    
    /// convineience function for registering cells in collection view
    /// - Parameter type : it takes the class type of cell
    func register<T: UICollectionViewCell>(_ type: T.Type) {
        register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
    
    /// Convienece function used for dequeing collection view cell, and type cast that to provided generic parameter
    /// - Parameters:
    ///   - type: Class type of cell
    ///   - indexPath: indexpath of cell
    /// - Returns: returns the type casted view
    func dequeueReusableCell<Cell: UICollectionViewCell>(ofType type: Cell.Type,for indexPath: IndexPath) -> Cell {
        return self.dequeueReusableCell(withReuseIdentifier: type.reuseIdentifier, for: indexPath) as! Cell
    }
    
    /// Convienece function used for dequeing UICollectionReusableView, and type cast that to provided generic parameter
    /// - Parameters:
    ///   - type: Class type of view
    ///   - indexPath: indexpath of view
    /// - Returns: returns the type casted view
    func dequeueReusableSupplementaryView<View: UICollectionReusableView>(ofType type: View.Type,for indexPath: IndexPath) -> View{
        return self.dequeueReusableSupplementaryView(ofKind: View.reuseIdentifier, withReuseIdentifier: View.reuseIdentifier, for: indexPath) as! View
    }
}

extension UITableView {
    
    /// Convienence function for registering cell
    /// - Parameter type: class type of cell
    func register<T: UITableViewCell>(_ type : T.Type) {
        register(T.self, forCellReuseIdentifier: T.reusableIdentifier)
    }
    
    /// Convienece function used for dequeing table view cell, and type cast that to provided generic parameter
    /// - Parameters:
    ///   - type: Class type of view
    ///   - indexPath: indexpath of view
    /// - Returns: returns the type casted view
    func dequeueReusableCell<Cell: UITableViewCell>(ofType type: Cell.Type,for indexPath: IndexPath) -> Cell {
        register(Cell.self)
        guard let cell = dequeueReusableCell(withIdentifier: Cell.reusableIdentifier, for: indexPath) as? Cell else {
            fatalError("Could not dequeue cell with identifier: \(Cell.reusableIdentifier)")
        }
        return cell
    }
    
    /// Convienece function used for dequeing table view header footer, and type cast that to provided generic parameter
    /// - Returns: the type cast view
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>() -> T where T: ReusableView {
        register(T.self, forHeaderFooterViewReuseIdentifier: T.reusableIdentifier)
        guard let cell = dequeueReusableHeaderFooterView(withIdentifier: T.reusableIdentifier) as? T else {
            fatalError("Could not dequeue Reusable HeaderFooterView with identifier: \(T.reusableIdentifier)")
        }
        return cell
    }
}

extension String {
    /// it will convert string to date  and exact fommated date whichever we want
    /// - Returns: it will return a formatted date string
    func getDate() -> String?{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "yyyy"
        
        let date: Date? = dateFormatterGet.date(from: self)
        print("Date",dateFormatterPrint.string(from: date!))
        return dateFormatterPrint.string(from: date!)
    }
}

extension TimeInterval {
    /// it will give a formated time like 2:20 min
    var minuteSecondMS: String {
        return String(format:"%d:%02d", minute, second)
    }
    var minute: Int {
        return Int((self/60).truncatingRemainder(dividingBy: 60))
    }
    var second: Int {
        return Int(truncatingRemainder(dividingBy: 60))
    }
    var millisecond: Int {
        return Int((self*1000).truncatingRemainder(dividingBy: 1000))
    }
}

extension Int {
    var msToSeconds: Double {
        return Double(self) / 1000
    }
}

class AttributedString {
    /// it is taking two different kind of text and return in a single text
    /// - Parameters:
    ///   - str1: it will take first text
    ///   - str2: it will take second text
    /// - Returns: NSMutableAttributedString  will combine two different strings and return in a attributed text
    class func setAttributedString(_ str1: String,_ str2: String) -> NSMutableAttributedString {
        let firstAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray,.font: UIFont.boldSystemFont(ofSize: 16)]
        let secondAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray]
        let firstString = NSMutableAttributedString(string: str1, attributes: firstAttributes)
        let secondString = NSAttributedString(string: str2, attributes: secondAttributes)
        firstString.append(secondString)
        return firstString
    }
}

extension Double {
    
    /// - Parameter currency:
    /// - Returns: it will return a currency symbol
    func getCurrency() -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current // Change this to another locale if you want to force a specific locale, otherwise this is redundant as the current locale is the default already
        formatter.numberStyle = .currency
        if let formattedTipAmount = formatter.string(from: self as NSNumber) {
            return formattedTipAmount
        }
        return ""
    }
}

extension String {
    /// it is a  currency text convert which will take country text and convert text into country currency symbol
    /// - Parameter price: it is taking price
    /// - Returns: it will return a currency symbol
    func getPriceWithSymbol(_ price: Double) -> String? {
        let locale = NSLocale(localeIdentifier: self)
        if locale.displayName(forKey: .currencySymbol, value: self) == self {
            let newlocale = NSLocale(localeIdentifier: self.dropLast() + "_en")
            return ((newlocale.displayName(forKey: .currencySymbol, value: self) ?? "") + "\(price)")
        }
        
        return ((locale.displayName(forKey: .currencySymbol, value: self) ?? "") + "\(price)")
    }
    
    mutating func getSubstringForHeader() -> String {
        if self.count > 15 {
            let range = self.index(endIndex, offsetBy: (16 - self.count))..<self.endIndex
            self.removeSubrange(range)
            self.append("..")
        }
        return self
    }
}

/// it will change  the whole app tint color from here
let globalAppTintColor = UIColor.systemRed

//MARK: get the number of lines from label
extension String {

    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }

    func heightOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.height
    }

    func sizeOfString(usingFont font: UIFont) -> CGSize {
        let fontAttributes = [NSAttributedString.Key.font: font]
        return self.size(withAttributes: fontAttributes)
    }
}
