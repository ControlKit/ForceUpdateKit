//
//  ViewPresenter.swift
//  ForceUpdateKit
//
//  Created by Maziar Saadatfar on 8/26/25.
//
import Foundation
import UIKit
public struct ForceUpdateViewPresenter {
    var config: ForceUpdateViewConfig
    public init(data: UpdateModel?, config: ForceUpdateViewConfig) {
        self.config = config
        if let localTitle = data?.title,
            let title = getLocalizeString(localTitle) { self.config.headerTitle = title }
        if let localButtonTitle = data?.button_title,
           let buttonTitle = getLocalizeString(localButtonTitle) { self.config.updateButtonNortmalTitle = buttonTitle }
        if let localVersion = data?.version,
            let version = getLocalizeString(localVersion) { self.config.versionText = version }
        if let localDescription = data?.description,
           let description = getLocalizeString(localDescription) { self.config.descriptionText = description }
        if let icon = data?.icon, let url = URL(string: icon) { setImageToConfig(from: url) }
    }
    
    func getLocalizeString(_ localize: LocalString) -> String? {
        guard let localizeString = localize.first(where: { $0.language == config.lang }) else {
            if let defaultLang = localize.first(where: { $0.language == "en" }) {
                return defaultLang.content
            } else {
                return nil
            }
        }
        return localizeString.content
    }
    
    func setImageToConfig(from url: URL) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            self.config.updateImage = UIImage(data: data)
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
