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
        showsHorizontalScrollIndicator = false
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        /// 画面内に表示されているcellを取得する
        let cells = visibleCells
        for cell in cells {
            transformScale(cell: cell)
        }
    }
    
    /// 計算してスケールを変更する
    private func transformScale(cell: UICollectionViewCell) {
        /// 最大スケール
        let maxScale: CGFloat = 1
        /// 縮小率
        let reductionRatio: CGFloat = -0.00025
        /// 画面の中心座標x
        let screenCenterX = UIScreen.main.bounds.width / 2
        /// Cellの中心座標x（nilにするとスクリーン上での座標を取得する）
        let cellCenterX = convert(cell.center, to: nil).x
        /// 画面の中心からcellの中心までの距離
        let centerDisX = abs(screenCenterX - cellCenterX)
        /// スケールy
        let scaleY = maxScale + reductionRatio * centerDisX
        /// 新しいスケールで実行する
        cell.transform = CGAffineTransform(scaleX: maxScale, y: scaleY)
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
        /// 表示したい要素群のwidthを計算する
        if cellItemsWidth == 0 {
            cellItemsWidth = floor(scrollView.contentSize.width/3)
        }
        
        /// スクロールした位置がしきい値を超えたら中央に戻す
        if (scrollView.contentOffset.x <= 0) || (cellItemsWidth*2 < scrollView.contentOffset.x) {
            scrollView.contentOffset.x = cellItemsWidth
        }
        
        /// 画面内に表示されているcellを取得する
        let cells = visibleCells
        for cell in cells {
            transformScale(cell: cell)
        }
    }
}
