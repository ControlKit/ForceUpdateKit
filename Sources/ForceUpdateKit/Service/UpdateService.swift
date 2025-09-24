//
//  UpdateServiceProtocol.swift
//
//
//  Created by Maziar Saadatfar on 10/12/23.
//

import Foundation

public class UpdateService: UpdateServiceProtocol {
    public init() {}
    public func update(request: UpdateRequest) async throws -> UpdateResponse? {
        do {
            guard let url = URL(string: request.route) else {
                return nil
            }
            var req = URLRequest(url: url)
            req.allHTTPHeaderFields = request.dictionary
            req.setValue(
                "application/json",
                forHTTPHeaderField: "Content-Type",
            )
            let (data, _) = try await URLSession.shared.data(for: req)
            if let updateResponse = try? JSONDecoder().decode(UpdateResponse.self, from: data) {
                print(updateResponse)
                return updateResponse
            } else {
                print("Invalid Response")
                return nil
            }
        } catch {
            print("Failed to Send POST Request \(error)")
            return nil
        }
    }
}
