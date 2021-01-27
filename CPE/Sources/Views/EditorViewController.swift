//
//  ViewController.swift
//  CPE
//
//  Created by Diana Tsarkova on 02.08.2020.
//  Copyright © 2020 Diana Tsarkova. All rights reserved.
//

import UIKit

class EditorViewController: UIViewController {
    // MARK: - private props
    private var flexibleSpace = UIBarButtonItem()
    private var itemsToolbar = [UIBarButtonItem]()
    private let viewCustom = TextCustomView()
    private var pictureView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "picture")
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        imageView.backgroundColor = .clear
        return imageView
    }()
//    private var colorsView = ColorsView()
    private var visualEffect: UIVisualEffectView = {
        let blur = UIBlurEffect(style: .regular)
        let effect = UIVisualEffectView(effect: blur)
        return effect.prepareLayout()
    }()
//    private var color: UIColor = .white
    private var isTextModeHidden = true {
        didSet {
            viewCustom.isHidden = isTextModeHidden
            visualEffect.isHidden = isTextModeHidden
        }
    }
    // MARK: - public props
    public var image: UIImage? {
        didSet {
            if let picture = image { pictureView.image = picture }
        }
    }
    // MARK: - override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Edit"
        view.backgroundColor = .white
//        colorsView.onSelectColor = { [weak self] color in
//            self?.color = color
//        }
        createToolbarItems()
        layoutConstraints()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureNavigation(for: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        configureNavigation(for: false)
    }
    // MARK: - objc methods
    @objc func textMode() {
        viewCustom.onDoneEditing = { textObj in
            self.addTextAsLabel(textObject: textObj)
            self.isTextModeHidden = true
        }
        isTextModeHidden = !isTextModeHidden
    }
    @objc func shapesMode() {
        // TODO: - shaping
    }
    @objc func eraserMode() {
        // TODO: - shaping
    }
    // MARK: - private methods
    private func configureNavigation(for appear: Bool) {
        navigationController?.setNavigationBarHidden(!appear, animated: true)
        navigationController?.setToolbarHidden(!appear, animated: true)
        configureNavigationItems()
    }
    private func configureNavigationItems() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "crop"), style: .plain, target: self, action: #selector(shapesMode))
        let undoItem = UIBarButtonItem(image: UIImage(named: "undo"), style: .plain, target: self, action: #selector(shapesMode))
        let redoItem = UIBarButtonItem(image: UIImage(named: "redo"), style: .plain, target: self, action: #selector(shapesMode))
        navigationItem.rightBarButtonItems = [redoItem, undoItem]
    }
    private func createToolbarItems() {
        flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        itemsToolbar.append(flexibleSpace)
        createToolBarItem(image: "text", action: #selector(textMode))
        createToolBarItem(image: "shapes", action: #selector(shapesMode))
        createToolBarItem(image: "edit", action: #selector(shapesMode))
        createToolBarItem(image: "eraser", action: #selector(eraserMode))
        toolbarItems = itemsToolbar
    }
    private func createToolBarItem(image: String, action: Selector) {
        let barItem = UIBarButtonItem(image: UIImage(named: image), style: .plain, target: self, action: action)
        itemsToolbar.append(barItem)
        itemsToolbar.append(flexibleSpace)
    }
    
    private func layoutConstraints() {
        view.addSubview(pictureView.prepareLayout())
//        view.addSubview(colorsView.prepareLayout())
        
        view.addSubview(visualEffect)
        view.addSubview(viewCustom.prepareLayout())
        isTextModeHidden = true
        visualEffect.pinEdgesToSuperviewEdges()
        viewCustom.pinToSuperview([.left, .right])
        viewCustom.heightAnchor ^= 300
        viewCustom.centerAtSuperview()
        
        pictureView.topAnchor ^= view.topAnchor + 50
        pictureView.pinToSuperview([.left, .right])
        NSLayoutConstraint.activate([
            pictureView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pictureView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pictureView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            pictureView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
        ])
    }
    
    private func addTextAsLabel(textObject: TextObject) {
        let label = ClassicLabel()
        label.textObjectToLabel(textObject: textObject)
        pictureView.addSubview(label.prepareLayout())
        label.layoutConstraint()
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.1
        label.sizeToFit()
        label.addGestureRecognizer(UIPinchGestureRecognizer(target: label, action: #selector(label.scalePiece)))
        label.addGestureRecognizer(UIRotationGestureRecognizer(target: label, action: #selector(label.rotate)))
    }
}
