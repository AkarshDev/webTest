//
//  HomeManager.swift
//  webTest
//
//  Created by Akarsh Ram on 17/07/22.
//

import Foundation

protocol HomeManagerDelegate {
    func didUpdateHome(_ homeManager: HomeManager, home: [HomeDatum])
    func didFailWithError(error: Error)
}


struct HomeManager{
    var delegate: HomeManagerDelegate?

    func apiCallForHomeList(){
       // actIndicator.startAnimating()
        if let url = URL(string: Constant().baseUrl) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil{
                    print(error)
                    DispatchQueue.main.async {
                       // actIndicator.stopAnimating()

                    }
                    return
                }
//                if let safeData = data {
//                    DispatchQueue.main.async {
//                       // actIndicator.stopAnimating()
//
//                    }
                    if let safeData = data {
                        if let homeDetails = self.parseJSON(homeData: safeData) {
                            self.delegate?.didUpdateHome(self, home: homeDetails.homeData)
                        }
                    }

                //    parseJSON(homeData: safeData)
    //                    let dataString = String(data: safeData, encoding: .utf8)
    //                    print(dataString)
              //  }
            }
            task.resume()
        }
    }

    func parseJSON(homeData:Data) -> Homemodel?{
        let decoder = JSONDecoder()
        do {
          let decodedData = try decoder.decode(Homemodel.self, from: homeData)
           // return decodedData.homeData
            return decodedData
            
        } catch  {
            print("erros \(error)")
            return nil
        }
        
    }
}

