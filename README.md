# RVNetwork

[![CI Status](https://img.shields.io/travis/26132769/RVNetwork.svg?style=flat)](https://travis-ci.org/26132769/RVNetwork)
[![Version](https://img.shields.io/cocoapods/v/RVNetwork.svg?style=flat)](https://cocoapods.org/pods/RVNetwork)
[![License](https://img.shields.io/cocoapods/l/RVNetwork.svg?style=flat)](https://cocoapods.org/pods/RVNetwork)
[![Platform](https://img.shields.io/cocoapods/p/RVNetwork.svg?style=flat)](https://cocoapods.org/pods/RVNetwork)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

RVNetwork is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'RVNetwork'
```

## How to use:
### Get Request:


```
Create a Network Route by confirming RVNetworkRoute protocol as below -->>

struct PostRoute: RVNetworkRoute {
    
    init(task: RVHTTPTask = .request) {
        self.task = task
    }
    var baseURL: String {
        return  "https://jsonplaceholder.typicode.com/"
    }
    
    var path: String? {
        return "posts"
    }
    
    var httpMethod: RVNetwork.RVHTTPMethod {
        return .get
    }
    
    var headers: RVNetwork.RVHTTPHeaders? {
        return nil
    }
    var task: RVNetwork.RVHTTPTask
    
}


In your Viewmodel of viewcontroller or action button -->>

    let postRoute = PostRoute()
    let service = RVNetwork.RVServiceRouter()
    service.isLoggingEnable = true
        
    service.performDataTask(postRoute) { [weak self] (result: Result<Post, RVNetworkingError>) in
        switch  result {
        case .success(let post):
            print(post)
            self?.post = post
        case .failure(let failure):
            print(failure)
        }
    }

```

## Author

Ravi Ranjan, r.ranjanchn@gmail.com

## License

RVNetwork is available under the MIT license. See the LICENSE file for more info.
# RVNetwork
