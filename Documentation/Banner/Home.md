# Types

  - [BannerPolicyState](/Documentation/Banner/BannerPolicyState.md)
  - [BannerPolicyItemModel.CodingKeys](/Documentation/Banner/BannerPolicyItemModel_CodingKeys.md)
  - [BannerCloseType](/Documentation/Banner/BannerCloseType.md)
  - [BannerLandingType](/Documentation/Banner/BannerLandingType.md)
  - [DefaultBannerPolicyItem.Content](/Documentation/Banner/DefaultBannerPolicyItem_Content.md)
  - [PopupBannerPolicyItem.Content](/Documentation/Banner/PopupBannerPolicyItem_Content.md)
  - [Banner](/Documentation/Banner/Banner.md)
  - [Heap](/Documentation/Banner/Heap.md)
  - [PriorityQueue](/Documentation/Banner/PriorityQueue.md)
  - [BannerPolicyItemModel](/Documentation/Banner/BannerPolicyItemModel.md)
  - [BannerPolicy](/Documentation/Banner/BannerPolicy.md)
  - [DefaultBannerPolicyItem](/Documentation/Banner/DefaultBannerPolicyItem.md)
  - [PopupBannerPolicyItem](/Documentation/Banner/PopupBannerPolicyItem.md)
  - [DefaultBannerView](/Documentation/Banner/DefaultBannerView.md):
    DefaultBannerView. \[DefaultBannerPolicyItem\] 을 Image Slider 형식으로 만들어줌.
    주의\! DefaultBannerPolicyItem 들은 같은 이미지 비율을 가져야 함.
  - [PopupBannerView](/Documentation/Banner/PopupBannerView.md):
    PopupBannerView. Content 높이에 따라서 View 를 보여줌.
    실제 bottom sheet 처럼 보여주기 위해서는 해당 View 를 present 할 때 UIViewController 의 배경색을 투명하게 혹은 dim 처리된 색상으로 변경하고, UIModalPresentationStyle 을 .overCurrentContext 로 지정해주어야 함.

# Global Typealiases

  - [LocalBannerPolicy](/Documentation/Banner/LocalBannerPolicy.md)
  - [DefaultBannerPolicy](/Documentation/Banner/DefaultBannerPolicy.md)
  - [PopupBannerPolicy](/Documentation/Banner/PopupBannerPolicy.md)

# Global Functions

  - [buildDefaultBannerView(category:​)](/Documentation/Banner/buildDefaultBannerView\(category_\).md)
  - [start()](/Documentation/Banner/start\(\).md)
  - [fetch()](/Documentation/Banner/fetch\(\).md)
  - [getBannerPolicy()](/Documentation/Banner/getBannerPolicy\(\).md)
  - [getBannerPolicy()](/Documentation/Banner/getBannerPolicy\(\).md)

# Global Variables

  - [instance](/Documentation/Banner/instance.md)
  - [landingPublisher](/Documentation/Banner/landingPublisher.md):
    `landingPublisher` 외부에서 Landing 할 화면을 구독할 수 있는 Publisher.
  - [state](/Documentation/Banner/state.md):
    `state`: BannerPolicyBloc 의 상태.
  - [dataSource](/Documentation/Banner/dataSource.md)

# Extensions

  - [PopupBannerPolicy](/Documentation/Banner/PopupBannerPolicy.md)
