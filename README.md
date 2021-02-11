# ios-linkinbio

Linkin.bio is a feature Later.com is working on so that users can have a visual link page so users can give a link to an online link aggregator in their Instagram bio link which can then forward users to urls based on the image they pick.

The data source for this data comes from the Later.com servers, and is rendered at http://linkin.bio/{username} [http://linkin.bio/latermedia](http://linkin.bio/latermedia) is a good example

As an exercise for iOS, we'd like you to make an iPhone app that would process these links from our server and display them in a simple iphone app. 

You can find the Linkin.bio posts for a profile by calling `https://api-prod.linkin.bio/api/pub/linkinbio_posts?instagram_profile_id=<id>`, and you can find the profile id for an Instagram account by calling `https://api-prod.linkin.bio/api/pub/instagram_profiles?social_profile=<account username>`. 

The exercise is to make the app look as follows:

Main View Controller            |  Web View Controller
:-------------------------:|:-------------------------:
![Main View Controller](https://github.com/Latermedia/ios-linkinbio/blob/master/Explore%20View.png)  |  ![Web View Controller](https://github.com/Latermedia/ios-linkinbio/blob/master/In%20app%20web%20view.png)

Do this by forking the repo and making a branch implementing the following features:

- For each post in the API response from the `viewDidLoad`, display the `thumb_url` in a collection view cell
- Underneath the thumburl, have a label showing only the domain for the `link_url`
- If a user taps on the collection item, open the web view controller with the `link_url` corresponding to the post

Bonus!

- Once the website from the `link_url` is *fully loaded* on the web view controller, grey out or lower the alpha the collection view cell that was tapped on so it's clear that link has already been visited. (it's okay if this only persists until the next time the app is loaded)


When you're complete, submit a pull request back to the public repo with your work and mention @smasuch on the request. If anything is unclear or you need help, please message steven.masuch@later.com.

