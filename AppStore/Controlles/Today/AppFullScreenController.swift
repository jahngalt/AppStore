//
//  AppFullScreenController.swift
//  AppStore
//
//  Created by Oleg Kudimov on 10/23/20.
//

import UIKit

class AppFullScreenController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var dismissHandler: (() -> ())?
    
    let headerCellId = "headerCellId"
    let cellId = "cellId"
    var todayItem: TodayItem?
    var statusBarHeight: CGFloat = 0
    let floatingContainerView = UIView()
    let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "close_button"), for: .normal)
        return button
    }()
    
    let translationY: CGFloat = -90 - 44
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0 {
            scrollView.isScrollEnabled = false
            scrollView.isScrollEnabled = true 
        }
        
        
        let transform = scrollView.contentOffset.y > 100 ? CGAffineTransform(translationX: 0, y: translationY) : .identity
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut) {
            
            self.floatingContainerView.transform = transform
        }
    }
    
    
    let tableView = UITableView(frame: .zero, style: .plain)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.clipsToBounds = true
        view.addSubview(tableView)
        tableView.fillSuperview()
        tableView.dataSource = self
        tableView.delegate = self
        
        setupCloseButton()
        
        //hide lines in tableView
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.register(AppFullScreenHeaderCell.self, forCellReuseIdentifier: headerCellId)
        tableView.register(AppFullScreenDescriptionCell.self, forCellReuseIdentifier: cellId)
        
        tableView.allowsSelection = false
        
        tableView.contentInsetAdjustmentBehavior = .never
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        
        tableView.contentInset = .init(top: 0, left: 0, bottom: statusBarHeight, right: 0)
        
        setupFloatingControls()
    }
    
    
    
    fileprivate func setupFloatingControls() {
        
        // TODO: Implement correct way to determine statusbar height
        //let bottomPadding = UIApplication.shared.statusBarFrame.height
        // hardcoded botton padding
        //let bottomPadding: CGFloat = -44
        
        //print(bottomPadding)
        
        floatingContainerView.clipsToBounds = true
        floatingContainerView.layer.cornerRadius = 16
        //floatingContainerView.backgroundColor = .red
        
        view.addSubview(floatingContainerView)
        
        floatingContainerView.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 16, bottom: -90 , right: 16), size: .init(width: 0, height: 90))
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        
        
        //adding blur effect
        let blurVisualEffect = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
        floatingContainerView.addSubview(blurVisualEffect)
        blurVisualEffect.fillSuperview()
        
        //add subviews
        let imageView = UIImageView(cornerRadius: 16)
        imageView.image = todayItem?.image
        imageView.constrainHeight(constant: 68)
        imageView.constrainWidth(constant: 68)
        
        
        let getButton = UIButton(title: "GET")
        getButton.setTitleColor(.white, for: .normal)
        getButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        getButton.backgroundColor = .darkGray
        getButton.layer.cornerRadius = 16
        getButton.constrainWidth(constant: 80)
        getButton.constrainHeight(constant: 32)
        
        let stackView = UIStackView(arrangedSubviews:
            [imageView,
             VerticalStackView(arrangedSubviews:
                                [UILabel(text: "Life Hack", font: .boldSystemFont(ofSize: 18)),
                                 UILabel(text: "Utilizing your time", font: .systemFont(ofSize: 14))]
                               , spacing: 4),
            getButton]
            , customSpaing: 16)
        floatingContainerView.addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 0, left: 16, bottom: 0, right: 16))
        stackView.alignment = .center
    }
    
    
    @objc fileprivate func handleTap() {
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut) {
            self.floatingContainerView.transform = .init(translationX: 0, y: -90)
        }
    }
    
    fileprivate func setupCloseButton() {
        view.addSubview(closeButton)
        closeButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor,padding: .init(top: 12, left: 0, bottom: 0, right: 0), size: .init(width: 80, height: 40))
        closeButton.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.item == 0 {
            let headerCell = tableView.dequeueReusableCell(withIdentifier: headerCellId) as! AppFullScreenHeaderCell
            
            headerCell.todayCell.todayItem = todayItem
            headerCell.todayCell.layer.cornerRadius = 0
            headerCell.clipsToBounds = true
            headerCell.todayCell.backgroundView = nil 
            return headerCell

        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! AppFullScreenDescriptionCell
        return cell 
    }
    
    
    @objc fileprivate func handleDismiss(button: UIButton) {
        button.isHidden = true
        dismissHandler?()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return TodayController.cellSize
        }
        return UITableView.automaticDimension
    }
    
}
