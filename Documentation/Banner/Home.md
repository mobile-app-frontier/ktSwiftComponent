# Types

  - [BannerPolicyState](/Documentation/Banner/BannerPolicyState)
  - [BannerPolicyItemModel.CodingKeys](/Documentation/Banner/BannerPolicyItemModel_CodingKeys)
  - [BannerCloseType](/Documentation/Banner/BannerCloseType)
  - [BannerLandingType](/Documentation/Banner/BannerLandingType)
  - [DefaultBannerPolicyItem.Content](/Documentation/Banner/DefaultBannerPolicyItem_Content)
  - [PopupBannerPolicyItem.Content](/Documentation/Banner/PopupBannerPolicyItem_Content)
  - [Banner](/Documentation/Banner/Banner)
  - [Heap](/Documentation/Banner/Heap)
  - [PriorityQueue](/Documentation/Banner/PriorityQueue)
  - [BannerPolicyItemModel](/Documentation/Banner/BannerPolicyItemModel)
  - [BannerPolicy](/Documentation/Banner/BannerPolicy)
  - [DefaultBannerPolicyItem](/Documentation/Banner/DefaultBannerPolicyItem)
  - [PopupBannerPolicyItem](/Documentation/Banner/PopupBannerPolicyItem)
  - [DefaultBannerView](/Documentation/Banner/DefaultBannerView):
    DefaultBannerView. \[DefaultBannerPolicyItem\] 을 Image Slider 형식으로 만들어줌.
    주의\! DefaultBannerPolicyItem 들은 같은 이미지 비율을 가져야 함.
  - [PopupBannerView](/Documentation/Banner/PopupBannerView):
    PopupBannerView. Content 높이에 따라서 View 를 보여줌.
    실제 bottom sheet 처럼 보여주기 위해서는 해당 View 를 present 할 때 UIViewController 의 배경색을 투명하게 혹은 dim 처리된 색상으로 변경하고, UIModalPresentationStyle 을 .overCurrentContext 로 지정해주어야 함.

# Global Typealiases

  - [LocalBannerPolicy](/Documentation/Banner/LocalBannerPolicy)
  - [DefaultBannerPolicy](/Documentation/Banner/DefaultBannerPolicy)
  - [PopupBannerPolicy](/Documentation/Banner/PopupBannerPolicy)

# Global Functions

  - [buildDefaultBannerView(category:​)](/Documentation/Banner/buildDefaultBannerView\(category_\))
  - [start()](/Documentation/Banner/start\(\))
  - [fetch()](/Documentation/Banner/fetch\(\))
  - [getBannerPolicy()](/Documentation/Banner/getBannerPolicy\(\))
  - [getBannerPolicy()](/Documentation/Banner/getBannerPolicy\(\))

# Global Variables

  - [instance](/Documentation/Banner/instance)
  - [landingPublisher](/Documentation/Banner/landingPublisher):
    `landingPublisher` 외부에서 Landing 할 화면을 구독할 수 있는 Publisher.
  - [state](/Documentation/Banner/state):
    `state`: BannerPolicyBloc 의 상태.
  - [dataSource](/Documentation/Banner/dataSource)

# Extensions

  - [PopupBannerPolicy](/Documentation/Banner/PopupBannerPolicy)
