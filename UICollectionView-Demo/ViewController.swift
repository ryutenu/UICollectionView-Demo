//
//  ViewController.swift
//  UICollectionView-Demo
//
//  Created by Alan Liu on 2021/11/30.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var titleCollectionView: UICollectionView!
    
    @IBOutlet weak var cardCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func actionButtonTapped(_ sender: UIButton) {
        print(sender.tag)
    }
}
