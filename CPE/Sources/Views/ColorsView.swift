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
    var onSelectColor: ((UIColor) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutIfNeeded()
    }
    
    override func layoutSubviews() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: frame.width / CGFloat(colors.count), height: frame.height)

        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ColorCell.self, forCellWithReuseIdentifier: ColorCell.cellId)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        addSubview(collectionView.prepareLayout())
        collectionView.pin(view: self)
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
extension ColorsView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        onSelectColor?(colors[indexPath.row])
    }
}

