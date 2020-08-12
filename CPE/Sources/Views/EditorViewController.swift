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
    private var textStyle = TextStyle()
    private var textString = ""
    private var flexibleSpace = UIBarButtonItem()
    private var itemsToolbar = [UIBarButtonItem]()
    private var pictureView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "picture")
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        return imageView
    }()
    private var colorsView = ColorsView()
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
        textStyle = TextStyle(font: "Helvetica Bold", size: 80, color: .gray)
        colorsView.onSelectColor = { [weak self] color in
            self?.textStyle.color = color
        }
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
        let alert = UIAlertController(title: "Text", message: "Enter a text", preferredStyle: .alert)

        alert.addTextField { (textField) in
            textField.text = ""
        }

        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields?[0]
            self.textString = textField?.text ?? ""
            
            if let image = self.pictureView.image {
                self.pictureView.image = EditorHelp.textToImage(with: self.textString, at: CGPoint(x: 300, y: 500), in: image, style: self.textStyle)
            }
        }))

        self.present(alert, animated: true)
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
        view.addSubview(colorsView.prepareLayout())
        pictureView.topAnchor ~= view.topAnchor + 50
        pictureView.pin(to: [.left, .right], view: view)
        NSLayoutConstraint.activate([
            pictureView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pictureView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pictureView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            pictureView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
        ])
        NSLayoutConstraint.activate([
            colorsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            colorsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            colorsView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -55),
            colorsView.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
