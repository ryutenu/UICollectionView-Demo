//
//  ViewController.swift
//  UICollectionView-Demo
//
//  Created by Alan Liu on 2021/11/30.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var titleCollectionView: UICollectionView!
    
    @IBOutlet weak var cardView: UIView!
    
    private var cardCollectionView: CardCollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCardView()
    }
    
    @IBAction func actionGoLeft(_ sender: Any) {
        cardCollectionView?.scrollToLeftItem()
    }
    
    @IBAction func actionGoRight(_ sender: Any) {
        cardCollectionView?.scrollToRightItem()
    }
    
    @IBAction func actionButtonTapped(_ sender: UIButton) {
        cardCollectionView?.scrollToTargetItem(index: sender.tag)
    }
    
    private func setupCardView() {
        let width = cardView.frame.width
        let height = cardView.frame.height
        
        cardCollectionView = CardCollectionView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        guard let cardCollectionView = cardCollectionView else { return }
        cardView.addSubview(cardCollectionView)
        
        cardCollectionView.scrollToFirstItem()
    }
}
