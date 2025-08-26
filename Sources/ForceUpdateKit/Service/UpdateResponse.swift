//
//  UpdateResponse.swift
//
//
//  Created by Maziar Saadatfar on 10/12/23.
//

import Foundation

public typealias LocalString = [LocalizedText]

public struct UpdateResponse: Codable {
    public var data: UpdateModel?
}
public struct UpdateModel: Codable {
    public let id: String?
    public let title: LocalString?
    public let description: LocalString?
    public let force: Bool?
    public let icon: String?
    public let link: String?
    public let button_title: LocalString?
    public let cancel_button_title: LocalString?
    public let version: LocalString?
    public let sdk_version: Int?
    public let minimum_version: String?
    public let maximum_version: String?
    public let created_at: String?
}
public struct LocalizedText: Codable {
    public let language: String?
    public let content: String?
}
