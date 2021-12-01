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
    
    private var cellItemsWidth: CGFloat = 0
    private let pageCount = 4
    
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
        cardFlowLayout.minimumLineSpacing = 0
        cardFlowLayout.scrollDirection = .horizontal
        cardFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
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
        return pageCount * 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = cardCollectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as? CardCell else {
            return UICollectionViewCell()
        }
        let fixedIndex = indexPath.row % pageCount
        cell.configureCell(index: fixedIndex)
        return cell
    }
}

extension ViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if cellItemsWidth == 0 {
            /// 表示したい要素群のwidthを計算する
            cellItemsWidth = floor(scrollView.contentSize.width/3)
        }
        
        if (scrollView.contentOffset.x <= 0) || (cellItemsWidth*2 < scrollView.contentOffset.x) {
            /// スクロールした位置がしきい値を超えたら中央に戻す
            scrollView.contentOffset.x = cellItemsWidth
        }
    }
}
