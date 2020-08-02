//
//  ColorsView.swift
//  CPE
//
//  Created by Diana Tsarkova on 02.08.2020.
//  Copyright © 2020 Diana Tsarkova. All rights reserved.
//

import UIKit

class ColorsView: UIView {
    var colors: [UIColor] = [.white, .red, .orange, .yellow, .green, .blue, .purple, .black, .brown, .cyan, .gray]
    var collectionView: UICollectionView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: frame.width, height: 700)

        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.register(ColorCell.self, forCellWithReuseIdentifier: ColorCell.cellId)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        addSubview(collectionView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ColorsView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ColorCell.cellId, for: indexPath) as? ColorCell
            else { return ColorCell() }
        cell.configure(with: colors[indexPath.row])
        return cell
    }
}

