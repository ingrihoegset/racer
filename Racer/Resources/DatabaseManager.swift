//
//  DatabaseManager.swift
//  Racer
//
//  Created by Ingrid on 14/02/2021.
//

import Foundation
import FirebaseDatabase


final class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
    static func safeEmail(emailAddress: String) -> String {
        var safeEmail = emailAddress.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        return safeEmail
    }
    

}

// MARK: - Account Management

extension DatabaseManager {
    
    public func userExists(with email: String,
                           completion: @escaping ((Bool) -> Void)) {
        
        var safeEmail = email.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        
        database.child(safeEmail).observeSingleEvent(of: .value, with: {snapshot in
            guard snapshot.value as? String != nil else {
                completion(false)
                return
            }
            
            completion(true)
        })
         
    }
    
    /// Insert new user to databaes
    public func insertUser(with user: RaceAppUser, completion: @escaping (Bool) -> Void) {
        database.child(user.safeEmail).setValue([
            "first_name": user.firstName,
            "last_name": user.lastName
        ], withCompletionBlock: { error, _ in
            guard error == nil else {
                print("Failed to write to database")
                completion(false)
                return
            }
            completion(true)
        })
    }
}

// MARK: - Sending times

extension DatabaseManager {
    
    /// Creates new race with target parter and first timestamp sent
    public func createNewRace(with partnerEmail: String, startTime: Time, completion: @escaping (Bool) -> Void) {
        guard let currentEmail = UserDefaults.standard.value(forKey: "email") as? String else {
            return
        }
        let currentSafeEmail = DatabaseManager.safeEmail(emailAddress: currentEmail)
        let partnerSafeEmail = DatabaseManager.safeEmail(emailAddress: partnerEmail)
        
        let ref = database.child("\(currentSafeEmail)")
        ref.observeSingleEvent(of: .value, with: { [weak self] snapshot in
            guard var userNode = snapshot.value as? [String: Any] else {
                completion(false)
                print("user not found")
                return
            }
            
            let raceId = "race_\(startTime.raceId)"
            
            let newRaceData: [String: Any] = [
                "raceId": raceId,
                "other_user_email": partnerSafeEmail,
                "starttime": startTime.timestamp
            ]
            
            let recipient_newRaceData: [String: Any] = [
                "raceId": raceId,
                "other_user_email": currentSafeEmail,
                "starttime": startTime.timestamp
            ]
            
            // Update recipient conversation entry
            
            self?.database.child("\(partnerSafeEmail)/races").observeSingleEvent(of: .value, with: { [weak self] snapshot in
                if var races = snapshot.value as? [[String: Any]] {
                    // append
                    print("example ", snapshot.value)
                    races.append(recipient_newRaceData)
                    self?.database.child("\(partnerSafeEmail)/races").setValue(races)
                }
                else {
                    // create
                    print("example ", snapshot.value)
                    self?.database.child("\(partnerSafeEmail)/races").setValue(recipient_newRaceData)
                }
            })
            
            
            // Update current user race entry
            if var races = userNode["races"] as? [[String: Any]] {
                // Races array exists for current user
                // You should append
                
                races.append(newRaceData)
                userNode["races"] = races
                ref.setValue(userNode, withCompletionBlock: { [weak self] error, _ in
                    guard error == nil else {
                        completion(false)
                        return
                    }
                    self?.finishCreatingRace(raceId: raceId, starttime: startTime, completion: completion)
                })
            }
            else {
                // conversation array does not exist
                // create it
                userNode["races"] = [
                    newRaceData
                ]
                
                ref.setValue(userNode, withCompletionBlock: { [weak self] error, _ in
                    guard error == nil else {
                        completion(false)
                        return
                    }
                    self?.finishCreatingRace(raceId: raceId, starttime: startTime, completion: completion)
                })
            }
        })
    }
    
    private func finishCreatingRace(raceId: String, starttime: Time, completion: @escaping (Bool) -> Void) {
        
        guard let currentEmail = UserDefaults.standard.value(forKey: "email") as? String else {
            completion(false)
            return
        }
        
        let safeEmail = DatabaseManager.safeEmail(emailAddress: currentEmail)
        
        let race: [String: Any] = [
            "raceId": raceId,
            "sender_email": safeEmail,
            "starttime": starttime.timestamp
        ]
        
        let value: [String: Any] = [
            "races": [
                race
            ]
        ]
        
        database.child("\(raceId)").setValue(value, withCompletionBlock: { error, _ in
            guard error == nil else {
                completion(false)
                return
            }
            completion(true)
        })
        
    }
    
    /// Gets all times for a given race
    public func getAllTimestampsForRace(with id: String, completion: @escaping (Result<String, Error>) -> Void) {
        
    }
    
    /// Sends a time with a target race
    public func sendTimestamp(to race: String, time: Time, completion: @escaping (Bool) -> Void) {
        let raceId = "race_\(race)"
        // add new timestamp to race
        database.child("\(raceId)/races").observeSingleEvent(of: .value, with: { [weak self] snapshot in
            guard let strongSelf = self else {
                return
            }
            
            guard var currentTimes = snapshot.value as? [[String: Any]] else {
                print("failed")
                print(snapshot.value)
                completion(false)
                return
            }
            print(snapshot.value)
            // Append new timestamp
            guard let currentEmail = UserDefaults.standard.value(forKey: "email") as? String else {
                completion(false)
                return
            }
            
            let safeEmail = DatabaseManager.safeEmail(emailAddress: currentEmail)
            
            let newTime: [String: Any] = [
                "raceId": time.raceId,
                "sender_email": safeEmail,
                "starttime": time.timestamp
            ]
            
            currentTimes.append(newTime)
            
            strongSelf.database.child("\(raceId)/races").setValue(currentTimes) { error, _ in
                guard error == nil else {
                    completion(false)
                    return
                }
                completion(true)
            }
        })
        
    }
    
    public enum DatabaseError: Error {
        case failedToFetch

        public var localizedDescription: String {
            switch self {
            case .failedToFetch:
                return "This means blah failed"
            }
        }
    }
}

extension DatabaseManager {
    
    public func getDataFor(path: String, completion: @escaping (Result<Any, Error>) -> Void) {
        self.database.child("\(path)").observeSingleEvent(of: .value, with: { snapshot in
            guard let value = snapshot.value else {
                completion(.failure(DatabaseError.failedToFetch))
                return
            }
            completion(.success(value))
        })
    }
}


struct Sender {
    var photoURL: String
    var senderId: String
    var displayName: String
}

struct Time {
    var sender: Sender
    var timestamp: Double
    var raceId: String
}


struct RaceAppUser {
    let firstName: String
    let lastName: String
    let emailAddress: String
    
    var safeEmail: String {
        var safeEmail = emailAddress.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        return safeEmail
    }
    
    var profilePictureFileName: String {
        return "\(safeEmail)_profile_picture.png"
    }
}
