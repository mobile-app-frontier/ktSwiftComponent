//
//  NetworkWebSocketSerivce.swift
//  GeniePhone
//
//  Created by pjx on 2023/02/20.
//

import Foundation
import Network


/// TODO : make websocket implementaion
class NetworkWebSocketService {
    @Published
    var internalReceiveData: Data = Data()
    
    @Published
    var internalConnectState: NetworkWebSocketConnectState = .waiting
    
    /// websocket connector
    var connection: NWConnection?

    /// WebSocketService property
    var receiveData: Published<Data>.Publisher { $internalReceiveData }
    
    var connectState: Published<NetworkWebSocketConnectState>.Publisher { $internalConnectState }
    
    
}
