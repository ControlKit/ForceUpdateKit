//
//  UpdateServiceProtocol.swift
//
//
//  Created by Maziar Saadatfar on 10/12/23.
//

import Foundation

public class UpdateService: UpdateServiceProtocol {
    public func update(request: UpdateRequest) async throws -> UpdateResponse {
        do {
            let url = URL(string: "https://my.api.mockaroo.com/forceupdate.json?key=2202ab40")!
            var request = URLRequest(url: url)
            request.setValue(
                "application/json",
                forHTTPHeaderField: "Content-Type"
            )
            let (data, _) = try await URLSession.shared.data(for: request)
            if let updateResponse = try? JSONDecoder().decode(UpdateResponse.self, from: data) {
                print(updateResponse)
                return updateResponse
            } else {
                print("Invalid Response")
                return UpdateResponse(forceUpdate: false)
            }
        } catch {
            print("Failed to Send POST Request \(error)")
            return UpdateResponse(forceUpdate: false)
        }
    }
}
