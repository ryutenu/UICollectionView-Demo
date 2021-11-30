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
    
    private let total = 4
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTitleCollectionView()
        
        setupCardCollectionView()
    }
    
    private func setupTitleCollectionView() {
        
    }
    
    private func setupCardCollectionView() {
        cardCollectionView.delegate = self
        cardCollectionView.dataSource = self
        
        cardCollectionView.register(UINib(nibName: "CardCell", bundle: nil), forCellWithReuseIdentifier: "CardCell")
        
        let cardFlowLayout = UICollectionViewFlowLayout()
        cardFlowLayout.itemSize = CGSize(width: view.bounds.width, height: 400)
        cardFlowLayout.minimumInteritemSpacing = 0
        cardFlowLayout.minimumLineSpacing = 0
        cardFlowLayout.scrollDirection = .horizontal
        cardCollectionView.collectionViewLayout = cardFlowLayout
    }
    
    @IBAction func actionButtonTapped(_ sender: UIButton) {
        print(sender.tag)
    }
}

extension ViewController: UICollectionViewDelegate {
    
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return total
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = cardCollectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as? CardCell else {
            return UICollectionViewCell()
        }
        cell.configureCell(index: indexPath.row)
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
}
