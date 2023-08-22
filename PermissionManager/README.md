# PermissionManager

앱에서 runtime에 필요한 권한을 확인 및 요청 할 수 있는 컴포넌트

- [plist 설정](#plist_설정)
- [Example](#Example)
- [구성](#구성)

 
## plist 설정

앱에서 특정 권한에 대한 요청 및 제어를 위해서는 plist에 해당 권한에 대한 설명을 명시해야 한다.
> **NOTE:_** 
project > target > build settings > info.plist values에 해당 권한 사용에 대한 설명을 명시 해야 함.

| permission | key |
| :--- | :--- |
| camera | INFOPLIST_KEY_NSCameraUsageDescription |
| contact | INFOPLIST_KEY_NSContactsUsageDescription |
| alwaysLocation | INFOPLIST_KEY_NSLocationAlwaysUsageDescription | 
| whenInUseLocation | INFOPLIST_KEY_NSLocationWhenInUseUsageDescription |
| mic | INFOPLIST_KEY_NSMicrophoneUsageDescription |
| photoLibrary(addOnly) | INFOPLIST_KEY_NSPhotoLibraryAddUsageDescription |
| photoLibrary(readWrite) | INFOPLIST_KEY_NSPhotoLibraryUsageDescription |

* notification 의 경우 plist.value에 설정을 추가 하는 방식이 아닌 capability에 추가 해야 한다.
project > target > capability > +capability > push notificaion 추가
* callKit 의 경우 app extension을 추가해야 함. [CallKit Doc](https://developer.apple.com/documentation/callkit/)

## Example

``` Swift

import SwiftUI
import PermissionManager

struct ContentView: View {
    var body: some View {
        VStack {
            Button {
                Task {
                    let result = await PermissionManager.instance.currentPermissionCondition(.camera)
                }
            } label: {
                Text("CheckPermission")
            }
            
            Button {
                Task {
                    await PermissionManager.instance.requestPermission(.camera)
                }
            } label: {
                Text("RequestPermission")
            }
        }
    }
}

```


## 구성

- [PermissionManager](#PermissionManager)
- Models
> ** NOTE:_ **
 * [PermissionCondition](#PermissionCondition)
 * [PermissionType](#PermissionType)
 * [PMPermissionCheck](#PMPermissionCheck)
 * [PMPermissionRequest](#PMPermissionRequest)

### PermissionManager

권한의 권한을 요청 및 확은을 하는 객체로, singleton으로 구성된다.

#### function
| function name | parameters | return | description |
| :--- | :--- | :--- | :--- | 
| checkPermissions | Array(PMPermissionCheck) | void | 권한들의 상태를 체크 | 
| currentPermissionCondition | PMPermissionCheck | PermissionCondition | 특정 권한에 대한 상태를 체크  |
| requestPermission | PMPermissionRequest | PermissionCondition | 특정 권한에 대한 동의요청 팝업을 system에 요청 |

> **NOTE:_** 모든 function들은 async로 진행한다.

### Models
- PermissionCondition
특정 권한에 대한 앱의 상태

#### PermissionCondition
 - granted(PermissionType): 권한이 승인 된 상태
 - denied: 권한이 거절된 상태 
 - undetermined: 아직 권한이 사용자로부터 노출되지 않은 상태
 - notSupport(reason:String?): 지원을 하지 않는 권한인 경우에 대한 상태
 
> **NOTE:_** 
notSupport 의 경우 해당 권한을 요청 할 수 있없는 상태 인경우에 해당한다.  

#### PermissionType

| type | description |
| :--- | :--- |
| callKit | call blocking permission | 
| notification | 알림 |
| mic | 마이크 |
| camera | 카메라 |
| alwaysLocation, whenInUseLocation | 위치 권한 |
| photoLibrary, photoLibraryLimited | 사진첩 |
| contacts | 연락처 | 


#### PMPermissionCheck

| type | description |
| :--- | :--- |
| callKit | call blocking permission | 
| notification | 알림 |
| mic | 마이크 |
| camera | 카메라 |
| alwaysLocation, whenInUseLocation | 위치 권한 |
| photoLibrary(PHPhotoLibraryRequest) | 사진첩 |
| contact | 연락처 | 


#### PMPermissionRequest

| type | description |
| :--- | :--- |
| callKit | call blocking permission | 
| notification(UNAuthorizationOptions?) | 알림 |
| mic | 마이크 |
| camera | 카메라 |
| alwaysLocation, whenInUseLocation | 위치 권한 |
| photoLibrary(PHPhotoLibraryRequest) | 사진첩 |
| contact | 연락처 | 

> **NOTE:_**  
 PHPhotoLibraryRequest :  addOnly, readWrite 를 지원하고, 읽기 전용인지 읽고쓰기 전용인지에 대한 권한이다.
 os14 부터는 해당 옵션을 명시 해야 한다. 
 UNAuthorizationOptions : notification에 대한 옵션으로 badge, sound, alarm등을 포함할 수 있다. [AppleDocument](https://developer.apple.com/documentation/usernotifications/unauthorizationoptions)
 
