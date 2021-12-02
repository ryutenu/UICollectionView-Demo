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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        /// 初期位置を真ん中にする
        cardCollectionView?.scrollToFirstItem()
    }
    
    @IBAction func actionButtonTapped(_ sender: UIButton) {
        print(sender.tag)
    }
    
    private func setupCardView() {
        let width = cardView.frame.width
        let height = cardView.frame.height
        
        let cardCollectionView = CardCollectionView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        self.cardCollectionView = cardCollectionView
        cardView.addSubview(cardCollectionView)
    }
}
