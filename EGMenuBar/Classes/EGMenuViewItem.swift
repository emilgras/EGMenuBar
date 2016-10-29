//
//  EGMenuViewItem.swift
//  EGMenuViewExample
//
//  Created by Emil Gräs on 21/10/2016.
//  Copyright © 2016 Emil Gräs. All rights reserved.
//

import UIKit

protocol EGMenuViewItemDelegate: class {
    func didSelectItemAtIndex(index: Int)
}

class EGMenuViewItem: UIView {
    
    weak var delegate: EGMenuViewItemDelegate?
    
    var index: Int?
    
    var imageView: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .ScaleAspectFit
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
    
    private func commonInit() {
        setupView()
        setupTapGesture()
    }
    
    private func setupView() {
        addSubview(imageView)
        setupImageViewConstraints()
    }
    
    private func setupImageViewConstraints() {
        imageView.leadingAnchor.constraintEqualToAnchor(leadingAnchor).active = true
        imageView.trailingAnchor.constraintEqualToAnchor(trailingAnchor).active = true
        imageView.topAnchor.constraintEqualToAnchor(topAnchor).active = true
        imageView.bottomAnchor.constraintEqualToAnchor(bottomAnchor).active = true
    }
    
    private func setupTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(EGMenuViewItem.handleTap))
        addGestureRecognizer(tap)
    }
    
    @objc private func handleTap() {
        if let index = index {
            delegate?.didSelectItemAtIndex(index)
        }
    }
    
}
