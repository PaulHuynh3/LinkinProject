//
//  ProfileRepository.swift
//  LinkinBio
//
//  Created by Paul Huynh on 2021-02-20.
//  Copyright © 2021 Ian MacKinnon. All rights reserved.
//

import Foundation

class ProfileRepository: ProfileRepositoryDelegate {
    private init() {}
    static let shared = ProfileRepository()
    let profileService = ProfileService()

    func get(recommendedPosts: [String], completion: @escaping (([Profile?]) -> Void)) {
        var profiles: [Profile] = []
        let dispatchGroup = DispatchGroup()
        for post in recommendedPosts {
            dispatchGroup.enter()
            let urlString = "https://api-prod.linkin.bio/api/pub/instagram_profiles?social_profile=\(post)"

            profileService.retrieve(urlString: urlString, success: { (profile: Profile) in
                profiles.append(profile)
                dispatchGroup.leave()
            }, failure: { error in
                print(error)
                dispatchGroup.leave()
            }
        )}
        dispatchGroup.notify(queue: .main) {
            completion(profiles)
        }
    }

    func getLinkinPosts(with ids: [String], completion: @escaping (([LinkinBioPost?]) -> Void)) {
        var linkinBioPost: [LinkinBioPost] = []
        let dispatchGroup = DispatchGroup()
        for id in ids {
            dispatchGroup.enter()
            let urlString = "https://api-prod.linkin.bio/api/pub/linkinbio_posts?instagram_profile_id=\(id)"

            profileService.retrieve(urlString: urlString, success: { (post: LinkinBioPost) in
                linkinBioPost.append(post)
                dispatchGroup.leave()
            }, failure: { error in
                print(error)
                dispatchGroup.leave()
            }
        )}
        dispatchGroup.notify(queue: .main) {
            completion(linkinBioPost)
        }
    }
}

protocol ProfileRepositoryDelegate {
//    func getLinkinPosts(recommendedPosts: [String]) -> [Profile]
}
