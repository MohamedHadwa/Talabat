//
//  LoginModel.swift
//  Talabat
//
//  Created by Mohamed Hadwa on 19/02/2023.
//

import Foundation

// MARK: - LoginModel
struct LoginModel: Codable {
    let status: Int?
    let message: String?
    let data: DataClass?
}

// MARK: - DataClass
struct DataClass: Codable {
    let token: String
    let user: User
}

// MARK: - User
struct User: Codable {
    let id: Int
    let firstName, lastName, fcmToken, deviceSerial: String
    let email: JSONNull?
    let phone, whatsapp: String
    let points: JSONNull?
    let countryCode: String
    let otp: JSONNull?
    let departmentID, isActive: Int
    let status: String
    let emailVerifiedAt: JSONNull?
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case fcmToken = "fcm_token"
        case deviceSerial = "device_serial"
        case email, phone, whatsapp, points
        case countryCode = "country_code"
        case otp
        case departmentID = "department_id"
        case isActive = "is_active"
        case status
        case emailVerifiedAt = "email_verified_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

