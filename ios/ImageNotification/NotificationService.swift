//
//  NotificationService.swift
//  ImageNotification
//
//  Created by Aleksandr Denisov on 23.09.23.
//

import UserNotifications
import FirebaseMessaging
import FirebaseAuth
import UIKit

class NotificationService: UNNotificationServiceExtension {

    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?

    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
        
        guard let bestAttemptContent = bestAttemptContent else {
            contentHandler(request.content)
            return
        }

        // Log entry
        print("didReceive notification called")
        
        // Modify content if needed (as an example, modifying the title)
        bestAttemptContent.title = "\(bestAttemptContent.title) [modified AA]"

        // Use Firebase SDK to handle media content
        Messaging.serviceExtension().populateNotificationContent(bestAttemptContent, withContentHandler: { modifiedContent in
            // Log for checking
            print("Finished populating notification content with image")

            // Return the modified content
            contentHandler(modifiedContent)
        })
    }   
    
    override func serviceExtensionTimeWillExpire() {
        // Called just before the extension will be terminated by the system.
        // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
        if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {
            contentHandler(bestAttemptContent)
        }
    }

}
