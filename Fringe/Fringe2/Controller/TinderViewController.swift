///
/// MIT License
///
/// TinderViewController.swift
//  Adelaide FringeTests
//
//  Created by Pham, Duy Anh - phady026 on 8/11/20.
//  Copyright © 2020 Pham, Duy Anh - phady026. All rights reserved.
//

import PopBounceButton
import MBProgressHUD

class TinderViewController: UIViewController {

    private let cardStack = SwipeCardStack()

    private let buttonStackView = ButtonStackView()

    var cardModels: [FringeEventItem] = []
    
    var eventModel: FringeEventModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventModel = FringeEventModel()
        loadData()
        
        cardStack.delegate = self
        cardStack.dataSource = self
        buttonStackView.delegate = self

        layoutButtonStackView()
        layoutCardStackView()
        configureBackgroundGradient()
    }
    
    func loadData() {
        if !isConnectedNetwork() {
            showNetConnectionAlert()
            return
        }
        
        let url_str = FringeEventListUrl
        guard let url = URL(string: url_str) else {
            self.showToastMessage(message: STR_URL_PASSING_ERROR)
            return
        }
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        getRequest(url: url, headers: nil) { (response) in
            MBProgressHUD.hide(for: self.view, animated: true)
            self.eventModel.setData(response)
            self.cardModels = self.eventModel.getRandomizeItems()
            self.cardStack.reloadData()
        }
    }
 
    func doRating(_ type: String, _ data: FringeEventItem) {
        if !isConnectedNetwork() {
            showNetConnectionAlert()
            return
        }
        
        let url_str = String(format: FringeEventRatingUrl, type, data.id)
        guard let url = URL(string: url_str) else {
            self.showToastMessage(message: STR_URL_PASSING_ERROR)
            return
        }
        
        getRequest(url: url, headers: nil) { (response) in
            let result = response["result"].stringValue.lowercased()
            if result == "success" {
                
            } else {
                let message = response["message"].stringValue
                self.showToastMessage(message: message)
            }
        }
    }
    
    func doInterest(_ data: FringeEventItem) {
        if !isConnectedNetwork() {
            showNetConnectionAlert()
            return
        }
        
        let url_str = String(format: FringeEventInterestUrl, data.id)
        guard let url = URL(string: url_str) else {
            self.showToastMessage(message: STR_URL_PASSING_ERROR)
            return
        }
        
        getRequest(url: url, headers: nil) { (response) in
            let result = response["result"].stringValue.lowercased()
            if result == "success" {
                
            } else {
                let message = response["message"].stringValue
                self.showToastMessage(message: message)
            }
        }
    }
    
    private func configureBackgroundGradient() {
        let backgroundGray = UIColor(red: 244 / 255, green: 247 / 255, blue: 250 / 255, alpha: 1)
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.white.cgColor, backgroundGray.cgColor]
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }

    private func layoutButtonStackView() {
        view.addSubview(buttonStackView)
        buttonStackView.anchor(left: view.safeAreaLayoutGuide.leftAnchor,
                               bottom: view.safeAreaLayoutGuide.bottomAnchor,
                               right: view.safeAreaLayoutGuide.rightAnchor,
                               paddingLeft: 60,
                               paddingBottom: 12,
                               paddingRight: 60)
    }

    private func layoutCardStackView() {
        view.addSubview(cardStack)
        cardStack.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                         left: view.safeAreaLayoutGuide.leftAnchor,
                         bottom: buttonStackView.topAnchor,
                         right: view.safeAreaLayoutGuide.rightAnchor)
    }

    @objc
    private func handleShift(_ sender: UIButton) {
        cardStack.shift(withDistance: sender.tag == 1 ? -1 : 1, animated: true)
    }
}

// MARK: Data Source + Delegates

extension TinderViewController: ButtonStackViewDelegate, SwipeCardStackDataSource, SwipeCardStackDelegate {

    func cardStack(_ cardStack: SwipeCardStack, cardForIndexAt index: Int) -> SwipeCard {
        let card = SwipeCard()
        card.footerHeight = 80
        card.swipeDirections = [.left, .up, .right]
        for direction in card.swipeDirections {
          card.setOverlay(TinderCardOverlay(direction: direction), forDirection: direction)
        }

        let model = cardModels[index]
        card.content = TinderCardContentView(withImage: model.image)
        card.footer = TinderCardFooterView(withTitle: "\(model.name), \(model.artist)", subtitle: model.venue)

        return card
    }

    func numberOfCards(in cardStack: SwipeCardStack) -> Int {
        return cardModels.count
    }

    func didSwipeAllCards(_ cardStack: SwipeCardStack) {
        print("Swiped all cards!")
    }

    func cardStack(_ cardStack: SwipeCardStack, didUndoCardAt index: Int, from direction: SwipeDirection) {
        print("Undo \(direction) swipe on \(cardModels[index].name)")
    }

    func cardStack(_ cardStack: SwipeCardStack, didSwipeCardAt index: Int, with direction: SwipeDirection) {
        print("Swiped \(direction) on \(cardModels[index].name)")
        switch direction {
        case .left:
            doRating("dislike", cardModels[index])
            break
        case .right:
            doRating("like", cardModels[index])
        case .up:
            doInterest(cardModels[index])
            break
        default:
            break
        }
    }

    func cardStack(_ cardStack: SwipeCardStack, didSelectCardAt index: Int) {
        print("Card tapped")
    }

    func didTapButton(button: TinderButton) {
        switch button.tag {
        case 1:
            cardStack.swipe(.right, animated: true)
        case 2:
          cardStack.swipe(.left, animated: true)
        case 3:
          cardStack.reloadData()
        default:
          break
        }
    }
}
