//
//  NetworkLayer.swift
//  FetchRewards
//
//  Created by Goutham on 8/20/22.
//

import Foundation

class NetworkLayer {
    
   weak var delegate:modelUpdate?
    
    init(delegate:modelUpdate) {
        self.delegate = delegate
    }
    
    func call(url: String) {
        let url = URL(string:url)!
         let task = URLSession.shared.dataTask(with: url) { [self] (data, response, error) in
            guard let data = data else { return }
             self.delegate!.updateViewModel(data: data)
            }
        task.resume()
        
    }
    
}
    
protocol modelUpdate: class  {
    func updateViewModel(data: Data)
}
