//
//  HomeViewController.swift
//  BaseProject
//
//  Created by Macbook on 6/13/19.
//  Copyright © 2019 translate.com. All rights reserved.
//

import UIKit
import SDWebImage

class HomeViewController: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    private let columnLayout = FlowLayout()
    var items: [ItemViewModel] = []
    private let hotkeyQueue = DispatchQueue(label: "HOTKEY_QUEUE")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configrueUI()
        self.configData()
    }
    
    private func configrueUI() {
        collectionView.collectionViewLayout = columnLayout
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ItemCollectionViewCell.self)
    }
    
    private func configData() {
        hotkeyQueue.async {
            NetworkManager.shareInstance.requestHotKeyword(urlString: KEY_API.search, params: nil, isShowLoader: true, method: .get, enableHeader: false, success: { (itemModels) in
                self.items = itemModels
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    self.collectionView.collectionViewLayout.invalidateLayout()
                }
            }) { (error) in
                self.showError(error: error.localizedDescription)
            }
        }
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = items[indexPath.row]
        let cell = collectionView.dequeueReusableCell(ofType: ItemCollectionViewCell.self, at: indexPath)
        cell.configCell(item: item)
        cell.itemImageView?.sd_setImage(with: item.iconURL, placeholderImage: UIImage(named: "ic_placeholder"))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 50.0, height: 50.0)
    }
}
