//
//  EGMenuBarItem.swift
//  EGMenuBarExample
//
//  Created by Emil Gräs on 21/10/2016.
//  Copyright © 2016 Emil Gräs. All rights reserved.
//

import UIKit

protocol EGMenuBarItemDelegate: class {
    func didSelectItemAtIndex(_ index: Int)
}

class EGMenuBarItem: UIView {
    
    weak var delegate: EGMenuBarItemDelegate?
    
    var index: Int?
    
    var imageView: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }
    
    var title: String? {
        didSet {
            // TODO:
        }
    }

    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    fileprivate func commonInit() {
        setupView()
        setupTapGesture()
    }
    
    fileprivate func setupView() {
        addSubview(imageView)
        setupImageViewConstraints()
    }
    
    fileprivate func setupImageViewConstraints() {
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    fileprivate func setupTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(EGMenuBarItem.handleTap))
        addGestureRecognizer(tap)
    }
    
    @objc fileprivate func handleTap() {
        if let index = index {
            delegate?.didSelectItemAtIndex(index)
        }
    }
    
}
