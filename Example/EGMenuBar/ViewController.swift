//
//  ViewController.swift
//  EGMenuBar
//
//  Created by emilgras on 10/29/2016.
//  Copyright (c) 2016 emilgras. All rights reserved.
//

import UIKit
import EGMenuBar

class ViewController: UIViewController {
    
    @IBOutlet weak var showMenuButton: UIButton!
    
    @IBAction func showMenuButtonTapped(sender: AnyObject) {
        if showMenuButton.titleLabel?.text == "show" {
            showMenuButton.setTitle("hide", forState: .Normal)
            menuBar.show()
        } else {
            showMenuButton.setTitle("show", forState: .Normal)
            menuBar.hide()
        }
    }
    
    private let menuBar = EGMenuBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuBar.datasource = self
        menuBar.delegate = self
        menuBar.center.x = view.center.x // remove later
        menuBar.center.y = view.center.y + 200
        view.addSubview(menuBar)
    }
    
}

extension ViewController: EGMenuBarDatasource {
    func numberOfItems() -> Int {
        return 4
    }
    
    func itemImages() -> [UIImage] {
        return [UIImage(named: "video")!, UIImage(named: "video")!, UIImage(named: "video")!, UIImage(named: "video")!]
    }
    
    func itemTitles() -> [String] {
        return ["video1", "video2", "video3", "video4"]
    }
}

extension ViewController: EGMenuBarDelegate {
    func didSelectItemAtIndex(menuView: EGMenuBar, index: Int) {
        self.showMenuButton.setTitle("show", forState: .Normal)
        menuView.hide()
    }
    
    func interItemSpacing(menuView: EGMenuBar) -> Double {
        return 6
    }
    
    func itemHeight(menuView: EGMenuBar) -> Double {
        return 60
    }
}
