//
//  ExploreViewModel.swift
//  LinkinBio
//
//  Created by Paul Huynh on 2021-02-20.
//  Copyright © 2021 Ian MacKinnon. All rights reserved.
//

import Foundation

class ExploreViewModel {

    var delegate: ExploreViewModelDelegate?
    var posts: [Post?] = []

    func configure(delegate: ExploreViewModelDelegate) {
        self.delegate = delegate
        retrieveData()
    }

    func buildExploreCellData(post: Post?, state: ExploreCollectionViewCell.State = .unselected) -> ExploreCollectionViewCell.PostData {
        return ExploreCollectionViewCell.PostData(imageString: post?.image_url, title: post?.link_url, state: state)
    }

    private func retrieveData() {
        ProfileRepository.shared.get(recommendedPosts: ["youtube", "google", "latermedia"]) { [weak self] profiles in

            let profileIds = profiles.compactMap {
                $0?.instagram_profiles.compactMap({
                    $0.id
                })
            }.flatMap { $0 }

            ProfileRepository.shared.getLinkinPosts(with: profileIds) { [weak self] linkinPosts in
                self?.posts = linkinPosts.compactMap {$0?.linkinbio_posts}.flatMap { $0 }
                self?.delegate?.reloadData()
            }
            self?.delegate?.reloadData()
        }
    }
}

protocol ExploreViewModelDelegate {
    func reloadData()
}
