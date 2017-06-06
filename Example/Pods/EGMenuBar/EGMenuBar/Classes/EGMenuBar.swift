//
//  EGMenuBar.swift
//  EGMenuBarExample
//
//  Created by Emil Gräs on 21/10/2016.
//  Copyright © 2016 Emil Gräs. All rights reserved.
//

import UIKit

public protocol EGMenuBarDatasource: class {
    func numberOfItems() -> Int
    func itemImages() -> [UIImage]
    func itemTitles() -> [String]
}

public protocol EGMenuBarDelegate: class {
    func didSelectItemAtIndex(_ menuView: EGMenuBar, index: Int)
    func interItemSpacing(_ menuView: EGMenuBar) -> Double // TODO: Make this optional
    func itemHeight(_ menuView: EGMenuBar) -> Double
}

open class EGMenuBar: UIView {
    
    // MARK: - Public Properties
    var itemHeight: CGFloat = 30
    var interItemSpacing: CGFloat = 10
    var menuHeight: CGFloat!
    var menuWidth: CGFloat!
    var menuBackgroundColor: UIColor = .white // TODO: Should be read/write
    
    // MARK: - Public Methods
    open func show() {
        UIView.animate(withDuration: 0.4, animations: {
            self.alpha = 1
            self.transform = CGAffineTransform.identity
        }) 
        
        
        
        UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.9, options: UIViewAnimationOptions(), animations: {
            let item = self.items[0]
            let constraint = self.itemCenterYConstraints[0]
            constraint.constant = 0
            item?.alpha = 1
            item?.transform = CGAffineTransform.identity
            self.layoutIfNeeded()
            }, completion: nil)
        
        UIView.animate(withDuration: 0.7, delay: 0.1, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.9, options: UIViewAnimationOptions(), animations: {
            let item = self.items[1]
            let constraint = self.itemCenterYConstraints[1]
            constraint.constant = 0
            item?.alpha = 1
            item?.transform = CGAffineTransform.identity
            self.layoutIfNeeded()
            }, completion: nil)
        
        UIView.animate(withDuration: 0.7, delay: 0.2, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.9, options: UIViewAnimationOptions(), animations: {
            let item = self.items[2]
            let constraint = self.itemCenterYConstraints[2]
            constraint.constant = 0
            item?.alpha = 1
            item?.transform = CGAffineTransform.identity
            self.layoutIfNeeded()
            }, completion: nil)
        
        UIView.animate(withDuration: 0.7, delay: 0.3, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.9, options: UIViewAnimationOptions(), animations: {
            let item = self.items[3]
            let constraint = self.itemCenterYConstraints[3]
            constraint.constant = 0
            item?.alpha = 1
            item?.transform = CGAffineTransform.identity
            self.layoutIfNeeded()
            }, completion: nil)
    }
    
    
    open func hide() {
        
        UIView.animate(withDuration: 0.3, delay: 0.1, options: UIViewAnimationOptions(), animations: {
            self.alpha = 0
            }, completion: nil)
        
        UIView.animate(withDuration: 0.4, delay: 0.0, options: UIViewAnimationOptions(), animations: {
            let scale = CGAffineTransform(scaleX: 0.9, y: 0.9)
            let transform = scale.translatedBy(x: 0, y: 15)
            self.transform = transform
            }, completion: nil)
        
        
        
        UIView.animate(withDuration: 0.8, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.9, options: UIViewAnimationOptions(), animations: {
            let item = self.items[3]
            let constraint = self.itemCenterYConstraints[3]
            constraint.constant = 100
            item?.alpha = 0
            item?.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            self.layoutIfNeeded()
            }, completion: nil)
        
        UIView.animate(withDuration: 0.7, delay: 0.05, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.9, options: UIViewAnimationOptions(), animations: {
            let item = self.items[2]
            let constraint = self.itemCenterYConstraints[2]
            constraint.constant = 100
            item?.alpha = 0
            item?.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            self.layoutIfNeeded()
            }, completion: nil)
        
        UIView.animate(withDuration: 0.6, delay: 0.1, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.9, options: UIViewAnimationOptions(), animations: {
            let item = self.items[1]
            let constraint = self.itemCenterYConstraints[1]
            constraint.constant = 100
            item?.alpha = 0
            item?.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            self.layoutIfNeeded()
            }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.15, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.9, options: UIViewAnimationOptions(), animations: {
            let item = self.items[0]
            let constraint = self.itemCenterYConstraints[0]
            constraint.constant = 100
            item?.alpha = 0
            item?.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            self.layoutIfNeeded()
            }, completion: nil)
    }
    
    /// not used yet
    func itemSelected(_ completion: @escaping (_ finished: Bool) -> Void) {
        
        UIView.animate(withDuration: 0.15, delay: 0, options: UIViewAnimationOptions(), animations: {
            self.alpha = 0
            }, completion: nil)

        UIView.animate(withDuration: 0.8, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.9, options: UIViewAnimationOptions(), animations: {
            let scale = CGAffineTransform(scaleX: 0.9, y: 0.9)
            let transform = scale.translatedBy(x: 0, y: 100)
            self.transform = transform
            
            for (index, item) in self.items {
                let constraint = self.itemCenterYConstraints[index]
                constraint.constant = 100
                item.alpha = 0
                item.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                self.layoutIfNeeded()
            }

            }, completion: {(finsihed) in
                completion(true)
            })

    }

    
    
    // MARK: - Datasource & Delegate
    open weak var datasource: EGMenuBarDatasource? {
        didSet {
            
        }
    }
    open weak var delegate: EGMenuBarDelegate? {
        didSet {
            setupMenuView()
            setupMenuItems()
            setupMenuItemImages()
            setupMenuItemTitles()
        }
    }

    // MARK: - Private
    fileprivate var items: [Int: EGMenuBarItem] = [:]
    fileprivate var itemCenterYConstraints: [NSLayoutConstraint] = []
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    fileprivate func commonInit() {
        
    }
    
    // MARK: - Helper Methods
    
    fileprivate func setupMenuView() {
        print("setup")
        if let height = delegate?.itemHeight(self) {
            print("height: \(height)")
            itemHeight = CGFloat(height)
        }
        if let spacing = delegate?.interItemSpacing(self) {
            print("spacing: \(spacing)")
            interItemSpacing = CGFloat(spacing)
        }
        if let numberOfItems = datasource?.numberOfItems() {
            menuHeight =  itemHeight + (interItemSpacing * 2)
            menuWidth = (CGFloat(numberOfItems) * itemHeight) + ((CGFloat(numberOfItems) + 1) * interItemSpacing)
            frame = CGRect(x: 0, y: 0, width: menuWidth, height: menuHeight)
        }
        
        alpha = 0
        backgroundColor = menuBackgroundColor
        layer.cornerRadius = menuHeight / 2
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 6.0
        layer.shadowOpacity = 0.4
        layer.borderWidth = 0.4
        layer.borderColor = UIColor.darkGray.cgColor

        let scale = CGAffineTransform(scaleX: 1, y: 1) // CGAffineTransformMakeScale(1, 1)
        let transform = scale.translatedBy(x: 0, y: 10)
        self.transform = transform
    }
    
    fileprivate func setupMenuItems() {
        if let numberOfItems = datasource?.numberOfItems() {
            var previosItem: EGMenuBarItem? = nil
            for index in 0...numberOfItems-1 {
                let item = EGMenuBarItem()
                item.translatesAutoresizingMaskIntoConstraints = false
                item.delegate = self
                item.layer.cornerRadius = itemHeight / 2
                item.layer.masksToBounds = true
                item.alpha = 0
                item.index = index
                items[index] = item
                addSubview(item)
                setupContraintForItem(item, withIndex: index, previousItem: previosItem, lastItem: index == numberOfItems - 1 ? true : false)
                previosItem = item
                setupInitialTransformForItem(item)
            }
        }
    }
    
    fileprivate func setupContraintForItem(_ item: EGMenuBarItem, withIndex index: Int, previousItem prevItem: EGMenuBarItem?, lastItem: Bool) {
        if let prevItem = prevItem, !lastItem {
            // middle items
            item.leadingAnchor.constraint(equalTo: prevItem.trailingAnchor, constant: interItemSpacing).isActive = true
            let centerYConstraint = item.centerYAnchor.constraint(equalTo: centerYAnchor)
            centerYConstraint.constant = 100
            centerYConstraint.isActive = true
            self.itemCenterYConstraints.append(centerYConstraint)
            item.widthAnchor.constraint(equalToConstant: itemHeight).isActive = true
            item.heightAnchor.constraint(equalToConstant: itemHeight).isActive = true
        } else if let prevItem = prevItem, lastItem {
            // last item
            item.leadingAnchor.constraint(equalTo: prevItem.trailingAnchor, constant: interItemSpacing).isActive = true
            item.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -interItemSpacing).isActive = true
            let centerYConstraint = item.centerYAnchor.constraint(equalTo: centerYAnchor)
            centerYConstraint.constant = 100
            centerYConstraint.isActive = true
            self.itemCenterYConstraints.append(centerYConstraint)
            item.widthAnchor.constraint(equalToConstant: itemHeight).isActive = true
            item.heightAnchor.constraint(equalToConstant: itemHeight).isActive = true
        } else {
            // first item
            item.leadingAnchor.constraint(equalTo: leadingAnchor, constant: interItemSpacing).isActive = true
            let centerYConstraint = item.centerYAnchor.constraint(equalTo: centerYAnchor)
            centerYConstraint.constant = 100
            centerYConstraint.isActive = true
            self.itemCenterYConstraints.append(centerYConstraint)
            item.widthAnchor.constraint(equalToConstant: itemHeight).isActive = true
            item.heightAnchor.constraint(equalToConstant: itemHeight).isActive = true
        }
        
    }
    
    fileprivate func setupInitialTransformForItem(_ item: EGMenuBarItem) {
        let scale = CGAffineTransform(scaleX: 0.5, y: 0.5)
        item.transform = scale
    }
 
    fileprivate func setupMenuItemImages() {
        if let images = datasource?.itemImages() {
            for (index, image) in images.enumerated() {
                items[index]?.image = image
            }
        }
    }
    
    fileprivate func setupMenuItemTitles() {
        if let titles = datasource?.itemTitles() {
            for (index, title) in titles.enumerated() {
                items[index]?.title = title
            }
        }
    }

}



extension EGMenuBar: EGMenuBarItemDelegate {
    func didSelectItemAtIndex(_ index: Int) {
        delegate?.didSelectItemAtIndex(self, index: index)
    }
}





