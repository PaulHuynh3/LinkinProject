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
    var recommendedPosts: [Profile?] = []

    func configure(delegate: ExploreViewModelDelegate) {
        self.delegate = delegate
        retrieveData()
    }

    func buildExploreCellData(post: Profile?) -> ExploreCollectionViewCell.PostData {
        return ExploreCollectionViewCell.PostData(imageString: post?.instagram_profiles.first?.avatar_url, title: post?.instagram_profiles.first?.name, state: .unselected)
    }

    private func retrieveData() {
        ProfileRepository.shared.get(recommendedPosts: ["youtube", "google", "latermedia"]) { [weak self] profiles in
            self?.recommendedPosts = profiles
            self?.delegate?.reloadData()
        }
    }
}

protocol ExploreViewModelDelegate {
    func reloadData()
}
