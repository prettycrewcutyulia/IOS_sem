//
//  ProfileModel.swift
//
public struct ProfileModel
{
    let avatar: String?// Аватар
    let firstName: String // Имя
    let secondName: String // Фамилия
    let middleName: String? // Отчество
    let nickname: String // никнейм
    let email: String // имейл
    let telegram: String? // телеграмм
    

    public init(avatar: String? = nil, firstName: String = "", secondName: String = "", middleName:String? = nil, nickname:String = "", email:String = "", telegram:String? = nil) {
        self.avatar = avatar
        self.firstName = firstName
        self.secondName = secondName
        self.middleName = middleName
        self.nickname = nickname
        self.email = email
        self.telegram = telegram
    }
}
