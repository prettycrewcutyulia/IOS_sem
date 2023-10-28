//
//  ProfileStorageWorker.swift
//
import Foundation

class ProfileStorageWorker: ProfileStorageLogic {
    /// Keys for userDefault dictionary.
    private struct Keys {
        static let firstName = "firstName"
        static let avatar = "avatar"
        static let secondName = "secondName"
        static let middleName = "middleName"
        static let nickname = "nickname"
        static let email = "email"
        static let telegram = "telegram"
    }

    /// Save profile to userDefaults.
    func save(_ profile: ProfileModel) {
        let avatar: String = profile.avatar ?? ""
        UserDefaults.standard.set(avatar, forKey: Keys.avatar)
        UserDefaults.standard.set(profile.firstName, forKey: Keys.firstName)
        UserDefaults.standard.set(profile.secondName, forKey: Keys.secondName)
        UserDefaults.standard.set(profile.middleName, forKey: Keys.middleName)
        UserDefaults.standard.set(profile.nickname, forKey: Keys.nickname)
        UserDefaults.standard.set(profile.email, forKey: Keys.email)
        UserDefaults.standard.set(profile.telegram, forKey: Keys.telegram)
    }

    /// Read profile from userDefaults.
    func read() -> ProfileModel {
        let avatar = UserDefaults.standard.string(forKey: Keys.avatar)
        let firstName = UserDefaults.standard.string(forKey: Keys.firstName)
        let secondName = UserDefaults.standard.string(forKey: Keys.secondName)
        let middleName = UserDefaults.standard.string(forKey: Keys.middleName)
        let nickname = UserDefaults.standard.string(forKey: Keys.nickname)
        let email = UserDefaults.standard.string(forKey: Keys.email)
        let telegram = UserDefaults.standard.string(forKey: Keys.telegram)
        
        return ProfileModel(
            avatar: avatar,
            firstName: firstName ?? "",
            secondName: secondName ?? "",
            middleName: middleName ?? "",
            nickname: nickname ?? "",
            email: email ?? "",
            telegram: telegram ?? ""
        )
    }
}
