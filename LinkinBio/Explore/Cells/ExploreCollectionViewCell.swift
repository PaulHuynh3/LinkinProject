//
//  ExploreCollectionViewCell.swift
//  LinkinBio
//
//  Created by Paul Huynh on 2021-02-20.
//  Copyright © 2021 Ian MacKinnon. All rights reserved.
//

import UIKit

class ExploreCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postTitle: UILabel!

    func configure(data: PostData?) {
        downloadImage(from: data?.imageString ?? "")
        postTitle.text = data?.title
        postTitle.textColor = data?.state == .unselected
            ? .red
            : .green
    }

    private func downloadImage(from string: String) {
        guard let url = URL(string: string) else { return }
        getData(from: url) { data, response, error in
            guard let imageData = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() { [weak self] in
                self?.postImageView.image = UIImage(data: imageData)
            }
        }
    }

    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }

    enum State: String, Codable {
        case selected
        case unselected
    }
}

extension ExploreCollectionViewCell {
    struct PostData {
        let imageString: String?
        let title: String?
        let state: State
    }
}
