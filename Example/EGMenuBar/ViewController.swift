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
            menuView.show()
        } else {
            showMenuButton.setTitle("show", forState: .Normal)
            menuView.hide()
        }
    }
    
    private let menuView = EGMenuView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuView.datasource = self
        menuView.delegate = self
        menuView.center.x = view.center.x // remove later
        menuView.center.y = view.center.y + 200
        view.addSubview(menuView)
    }
    
}

extension ViewController: EGMenuViewDatasource {
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

extension ViewController: EGMenuViewDelegate {
    func didSelectItemAtIndex(menuView: EGMenuView, index: Int) {
        self.showMenuButton.setTitle("show", forState: .Normal)
        menuView.hide()
    }
    
    func interItemSpacing(menuView: EGMenuView) -> Double {
        return 6
    }
    
    func itemHeight(menuView: EGMenuView) -> Double {
        return 60
    }
}
