//
//  iOSConnectivity.swift
//  ReadTracker
//
//  Created by Rei Soemanto on 02/04/26.
//

import Foundation
import WatchConnectivity
import Combine

class iOSConnectivity: NSObject, ObservableObject, WCSessionDelegate {
    var session: WCSession
    
    init(session: WCSession = .default) {
        self.session = session
        super.init()
        session.delegate = self
        session.activate()
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: (any Error)?) {
        
    }
    
    func sendToiOS(data: Book) {
        if session.isReachable {
            let dataToSend: [String: Any] = [
                "title": data.title,
                "author": data.author,
                "genre": data.genre,
                "image": data.image
            ]
            
            session.sendMessage(dataToSend, replyHandler: nil) { error in
                print("Error sending message: \(error.localizedDescription)")
            }
        } else {
            print("Session is not reachable!")
        }
    }
}
