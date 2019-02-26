//
//  ViewController.swift
//  Draw-Undo
//
//  Created by Naattudurai Eswaramurthy on 25/02/19.
//  Copyright © 2019 Naattudurai Eswaramurthy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let canvas = Canvas()
    
    let undoButton:UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Undo", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleUndo), for: .touchUpInside)
        return button
    }()
    
    let clearButton:UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Clear", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleClear), for: .touchUpInside)
        return button
    }()
    
    let redButton:UIButton = {
       let button = UIButton(type: .system)
        button.backgroundColor = .red
        button.layer.borderWidth = 1
        
        button.addTarget(self, action: #selector(handleColorChanged), for: .touchUpInside)
        return button
        
    }()
    let blueButton:UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .blue
        button.layer.borderWidth = 1
        
        button.addTarget(self, action: #selector(handleColorChanged), for: .touchUpInside)
        return button
        
    }()
    let greenButton:UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .green
        button.layer.borderWidth = 1
        
        button.addTarget(self, action: #selector(handleColorChanged), for: .touchUpInside)
        return button
        
    }()
    
    let slider:UISlider = {
        let slideer = UISlider()
        slideer.minimumValue = 1
        slideer.maximumValue = 10
        slideer.addTarget(self, action: #selector(handleSliderChanged), for: .valueChanged)
        return slideer
    }()
    
    @objc fileprivate func handleSliderChanged()
    {
        canvas.setStokeWidth(width: CGFloat(slider.value))
    }
    
    @objc fileprivate func handleColorChanged(selectedButton:UIButton)
    {
        canvas.setStokeColor(color: selectedButton.backgroundColor ?? .black)
    }
    
    @objc fileprivate func handleUndo()
    {
        canvas.Undo()
    }
    
    @objc fileprivate func handleClear()
    {
        canvas.Clear()
    }
    
    
    override func loadView() {
        self.view = canvas
    }
    
    fileprivate func layoutClearUndoViews() {
        
        let colorsStackView = UIStackView(arrangedSubviews: [redButton, blueButton, greenButton])
        colorsStackView.distribution = .fillEqually
        
        
        let stackView = UIStackView(arrangedSubviews: [undoButton, clearButton, colorsStackView, slider])
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(stackView)
        
        stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        canvas.backgroundColor = .white
        
        layoutClearUndoViews()

    }


}


