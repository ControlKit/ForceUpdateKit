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
            let (data, res) = try await URLSession.shared.data(for: req)
            if (res as? HTTPURLResponse)?.statusCode == 204 {
                print("Force Update Response --> 204")
                return nil
            }
            if let updateResponse = try? JSONDecoder().decode(UpdateResponse.self, from: data) {
                print("Force Update Response --> 200")
                print(updateResponse)
                return updateResponse
            } else {
                print("Force Update Response --> Decode Error")
                return nil
            }
        } catch {
            print("Failed to Request Force Update \(error)")
            return nil
        }
    }
}
