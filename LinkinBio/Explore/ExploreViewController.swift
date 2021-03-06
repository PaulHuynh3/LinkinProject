//
//  ViewController.swift
//  LinkinBio
//
//  Created by Ian MacKinnon on 2016-04-11.
//  Copyright © 2016 Ian MacKinnon. All rights reserved.
//

import UIKit

class ExploreViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    let viewModel = ExploreViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.configure(delegate: self)
        setup()
    }

    private func setup() {
        registerCell()
        registerReuseableHeaderView()
        navigationItem.title = "Explore"
    }

    private func registerCell() {
        let nib = UINib(nibName: String(describing: ExploreCollectionViewCell.self), bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: String(describing: ExploreCollectionViewCell.self))
    }

    private func registerReuseableHeaderView() {
        let headerNib = UINib(nibName: String(describing: PostReuseableHeaderView.self), bundle: nil)
        collectionView.register(headerNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: PostReuseableHeaderView.self))
    }
}

extension ExploreViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.posts.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let exploreCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ExploreCollectionViewCell.self), for: indexPath) as? ExploreCollectionViewCell else { fatalError("Failed to dequereusable cell") }
        let post = viewModel.posts[indexPath.row]
        exploreCell.configure(data: viewModel.buildExploreCellData(post: post))
        return exploreCell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let urlString = viewModel.posts[indexPath.row]?.link_url,
              let url = URL(string: urlString) else { return }

        if let webViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WebViewController") as? WebViewController {
            webViewController.configure(urlString: urlString)
            navigationController?.pushViewController(webViewController, animated: true)
        } else {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        viewModel.posts[indexPath.row] = Post(image_url: viewModel.posts[indexPath.row]?.image_url ?? "", link_url: urlString, state: .selected)
        collectionView.reloadItems(at: [indexPath])
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: PostReuseableHeaderView.self), for: indexPath)
        return headerView
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width, height: 70)
    }
}

extension ExploreViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let itemsPerRow: CGFloat = 3
        let width = collectionView.bounds.size.width/itemsPerRow - 10
        let sizeForItem = CGSize(width: width, height: 150)
        return sizeForItem
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

extension ExploreViewController: ExploreViewModelDelegate {
    func reloadData() {
        collectionView.reloadData()
    }
}
