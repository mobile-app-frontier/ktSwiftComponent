# Types

  - [BannerPolicyState](./BannerPolicyState)
  - [BannerPolicyItemModel.CodingKeys](./BannerPolicyItemModel_CodingKeys)
  - [BannerCloseType](./BannerCloseType)
  - [BannerLandingType](./BannerLandingType)
  - [DefaultBannerPolicyItem.Content](./DefaultBannerPolicyItem_Content)
  - [PopupBannerPolicyItem.Content](./PopupBannerPolicyItem_Content)
  - [Banner](./Banner)
  - [Heap](./Heap)
  - [PriorityQueue](./PriorityQueue)
  - [BannerPolicyItemModel](./BannerPolicyItemModel)
  - [BannerPolicy](./BannerPolicy)
  - [DefaultBannerPolicyItem](./DefaultBannerPolicyItem)
  - [PopupBannerPolicyItem](./PopupBannerPolicyItem)
  - [DefaultBannerView](./DefaultBannerView):
    DefaultBannerView. \[DefaultBannerPolicyItem\] 을 Image Slider 형식으로 만들어줌.
    주의\! DefaultBannerPolicyItem 들은 같은 이미지 비율을 가져야 함.
  - [PopupBannerView](./PopupBannerView):
    PopupBannerView. Content 높이에 따라서 View 를 보여줌.
    실제 bottom sheet 처럼 보여주기 위해서는 해당 View 를 present 할 때 UIViewController 의 배경색을 투명하게 혹은 dim 처리된 색상으로 변경하고, UIModalPresentationStyle 을 .overCurrentContext 로 지정해주어야 함.

# Global Typealiases

  - [LocalBannerPolicy](./LocalBannerPolicy)
  - [DefaultBannerPolicy](./DefaultBannerPolicy)
  - [PopupBannerPolicy](./PopupBannerPolicy)

# Global Functions

  - [buildDefaultBannerView(category:​)](./buildDefaultBannerView\(category_\))
  - [start()](./start\(\))
  - [fetch()](./fetch\(\))
  - [getBannerPolicy()](./getBannerPolicy\(\))
  - [getBannerPolicy()](./getBannerPolicy\(\))

# Global Variables

  - [instance](./instance)
  - [landingPublisher](./landingPublisher):
    `landingPublisher` 외부에서 Landing 할 화면을 구독할 수 있는 Publisher.
  - [state](./state):
    `state`: BannerPolicyBloc 의 상태.
  - [dataSource](./dataSource)

# Extensions

  - [PopupBannerPolicy](./PopupBannerPolicy)
