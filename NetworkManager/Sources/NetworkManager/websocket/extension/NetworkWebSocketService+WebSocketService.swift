//
//  NetworkWebSocketService+WebSocketService.swift
//  GeniePhone
//
//  Created by pjx on 2023/02/20.
//

import Foundation
import Network


extension NetworkWebSocketService : WebSocketService {
    
    /// default port : 80
    func connect(url: URL) {
        let host = url.getHost() ?? ""
        let port = url.port ?? 80
        
        
        guard let connectionPort = NWEndpoint.Port(rawValue: UInt16(port)) else {
            return
        }
        
        connection = NWConnection(host: NWEndpoint.Host(host), port: connectionPort, using: .tcp)
                
        guard let connection = connection else {
            // throw exception?
            return
        }
        
        /// state handle
        connection.stateUpdateHandler = { [weak self] state in
            self?.updateState(state: state)
        }
        
        connection.receiveMessage(completion: { completeContent, contentContext, isComplete, error in
            if let error = error {
                /// handle error
                debugPrint("error occure : \(error.localizedDescription)")
            }
            
            guard let data = completeContent else {
                /// ignore data
                return
            }
            
            Task {
                let _ = await MainActor.run(body: { [weak self] in
                    self?.internalReceiveData = data
                })
            }
            
        })
                     
        connection.start(queue: .global())
    }
    
    func send(data: Data) {
        self.connection?.send(content: data, completion: .idempotent)
    }
    
    
}


extension NetworkWebSocketService {
    
    private func updateState (state: NWConnection.State) {
        Task {
            await MainActor.run(body: { [weak self] in
                switch state {
                case .ready:
                    self?.internalConnectState = .connecting
                    break
                case .failed(let error):
                    print("WebSocket connection failed: \(error.localizedDescription)")
                    
                default:
                    break
                }
            })
        }
    }
}
