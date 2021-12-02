//
//  CardCollectionView.swift
//  UICollectionView-Demo
//
//  Created by Alan Liu on 2021/12/02.
//

import UIKit

class CardCollectionView: UICollectionView {
    
    private let cellIdentifier = "CardCell"
    private let pageCount = 4
    private var cellItemsWidth: CGFloat = 0
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        delegate = self
        dataSource = self
        register(UINib(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
    }
    
    convenience init(frame: CGRect) {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: frame.width * 0.8, height: frame.height)
        layout.minimumLineSpacing = 20
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        self.init(frame: frame, collectionViewLayout: layout)
        
        backgroundColor = .clear
        decelerationRate = .fast
//        showsHorizontalScrollIndicator = false
    }
}

extension CardCollectionView: UICollectionViewDelegate {
    
}

extension CardCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pageCount * 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? CardCell else {
            return UICollectionViewCell()
        }
        let fixedIndex = indexPath.row % pageCount
        cell.configureCell(index: fixedIndex)
        return cell
    }
}

extension CardCollectionView: UIScrollViewDelegate {
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
