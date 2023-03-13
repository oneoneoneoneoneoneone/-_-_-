//
//  _HomeViewController.swift
//  Nusinsa
//
//  Created by hana on 2022/08/12.
//

import UIKit
import SnapKit

class _HomeViewController: UIViewController {
    final let cellWidth = UIScreen.main.bounds.width

    final var list: [Int] = (1...5).map{$0}//: [UIColor] = [.red, .blue, .purple]
    
    var timer: Timer?
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = .init(width: cellWidth, height: 400)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = .zero
        collectionView.clipsToBounds = true
        collectionView.isPagingEnabled = true
        
        collectionView.register(HomeBannerCell.self, forCellWithReuseIdentifier: "HomeBannerCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    lazy var pageLabel: UILabel = {
        var label = UILabel()
        label.textColor = .white
        label.backgroundColor = .black.withAlphaComponent(0.2)
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textAlignment = .center
        label.layer.cornerRadius = 5
        label.text = "1 / \(list.count - 2) >"

        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //3,1,2,3,1
        list.insert(list[list.count-1], at: 0)
        list.append(list[1])
        
        setNavigationbar()
        setLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        collectionView.setContentOffset(.init(x: cellWidth, y: collectionView.contentOffset.y), animated: false)
        
        startTimer()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        stopTimer()
    }
    
    func setLayout(){
        [collectionView, pageLabel].forEach{
            view.addSubview($0)
        }
        
        collectionView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(400)
        }
        
        pageLabel.snp.makeConstraints{
            $0.trailing.bottom.equalTo(collectionView)
            $0.height.equalTo(25)
            $0.width.equalTo(60)
        }
    }
    
    func setNavigationbar(){
        let alarmLeftItem = UIBarButtonItem()
        alarmLeftItem.image = UIImage(systemName: "bell")
        alarmLeftItem.style = .plain
        
        let searchRightItem = UIBarButtonItem()
        searchRightItem.image = UIImage(systemName: "magnifyingglass")
        searchRightItem.style = .plain
        
        let basketRightItem = UIBarButtonItem()
        basketRightItem.image = UIImage(systemName: "bag")
        basketRightItem.style = .plain
        
        navigationItem.title = "NUSINSA"
        navigationItem.leftBarButtonItem = alarmLeftItem
        navigationItem.rightBarButtonItems = [basketRightItem,searchRightItem]
        
        //스와이프액션시 네비게이션 바를 숨기는
//        navigationController?.hidesBarsOnSwipe = true
    }
    
    private func startTimer(){
        guard timer == nil else {return}
        
        timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true, block: {_ in
            self.collectionViewToNextCell()
        })
    }
    
    private func stopTimer(){
        timer?.invalidate()
        timer = nil
    }
    
    private func collectionViewToNextCell(){
        //3,1,2,3,1
        self.collectionView.setContentOffset(.init(x: self.collectionView.contentOffset.x + self.cellWidth, y: self.collectionView.contentOffset.y), animated: true)
        
        if self.collectionView.contentOffset.x == self.cellWidth * Double(self.list.count - 1){
            self.collectionView.setContentOffset(.init(x: self.cellWidth, y: self.collectionView.contentOffset.y), animated: false)
            self.collectionView.setContentOffset(.init(x: self.cellWidth * Double((self.collectionView.visibleCells.first?.tag ?? 0) + 1), y: self.collectionView.contentOffset.y), animated: true)
        }
    }
}

extension _HomeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeBannerCell", for: indexPath) as! HomeBannerCell

        switch indexPath.row{
        case 0:
            cell.tag = list.count - 2
        case list.count - 1:
            cell.tag = 1
        default:
            cell.tag = indexPath.row
        }
        cell.setData()
        
        return cell
    }
        
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        //animated = false 했을 때 오류난 이유.. visibleCells = nil 인데 [0].tag를 가져오려고 해서...
        if(collectionView.visibleCells.count > 0){
            pageLabel.text = "\(collectionView.visibleCells[0].tag) / \(list.count - 2) >"
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if collectionView.visibleCells.count > 0{
            let currentCell = collectionView.visibleCells[0] as! HomeBannerCell
            //f -> b) -에서 +
            currentCell.imageView.frame.origin.x = scrollView.contentOffset.x - currentCell.frame.origin.x
            
            if collectionView.visibleCells.count > 1{
                let nextCell = collectionView.visibleCells[1] as! HomeBannerCell
                nextCell.imageView.frame.origin.x = scrollView.contentOffset.x - nextCell.frame.origin.x
            }
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        stopTimer()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x == 0 {
                collectionView.setContentOffset(.init(x: cellWidth * CGFloat(list.count - 2), y: collectionView.contentOffset.y), animated: false)
        }
        if scrollView.contentOffset.x == cellWidth * CGFloat(list.count - 1){
            collectionView.setContentOffset(.init(x: cellWidth, y: scrollView.contentOffset.y), animated: false)
        }
        
        startTimer()
    }
}
