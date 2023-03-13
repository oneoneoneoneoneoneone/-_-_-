//
//  HomeBannerCell.swift
//  Nusinsa
//
//  Created by hana on 2022/08/16.
//

import UIKit

class HomeBannerCell: UICollectionViewCell{
    var imageView: UIImageView = {
        var imageView = UIImageView()
        imageView.sizeToFit()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var TitleLabel: UILabel = {
        var label = UILabel()
        label.text = "@@@ S/S 컬렉션"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .white
        
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        var label = UILabel()
        label.text = "최대 80% 할인 쿠폰 증정"
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.textColor = .white
        
        return label
    }()
    
    private func setLayout(){
        [imageView, TitleLabel, descriptionLabel].forEach{
            addSubview($0)
        }
        
        imageView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        TitleLabel.snp.makeConstraints{
            $0.top.equalTo(frame.width*2/3)
            $0.centerX.equalToSuperview()
        }
        descriptionLabel.snp.makeConstraints{
        $0.top.equalTo(TitleLabel.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
    }
    
    func setData(){//(color: UIColor){
        self.clipsToBounds = true
        setLayout()
        
        loadImage(row: self.tag)
    }
    
    private func loadImage(row: Int){
        guard let url = URL(string:"https://images.pexels.com/photos/53421\(row)/pexels-photo-53421\(row).jpeg?auto=compress&cs=tinysrgb&w=400") else {return}
        let urlRequest = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: urlRequest, completionHandler: {[weak self] data, response, error in
            if let error = error {
                fatalError(error.localizedDescription)
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("response Error")
                return
            }
            
            guard response.statusCode == 200 else {
                print("response Error - \(response.statusCode)")
                return
            }
            
            guard let data = data,
                  let image = UIImage(data: data) else {
                print("data Parsing Error")
                return
            }
            
            DispatchQueue.main.async {
                self?.imageView.image = image
            }
        })
        
        task.resume()
    }
}
