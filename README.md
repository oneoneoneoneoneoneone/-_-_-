# MUSINSA-banner-CloneCoding
#Carousel CollectionView #Infinite CollectionView

![Mar-13-2023 14-36-27](https://user-images.githubusercontent.com/94464179/224616704-805d5dff-59a5-4935-8ad3-fed299f57935.gif)

</br></br></br></br>


## HomeViewController.swift
- 콜렉션뷰의 numberOfItems를 Int.Max로 잡고 유효한 페이지 숫자를 계산해서 보여줌.
<details>
<summary>페이징될 때 셀 이미지 고정된 것처럼 보이기</summary>
<div markdown="1">

- page가 넘어갈 때, imageView.frame.origin.x값의 범위는 -cell.width ~ 0
~~~swift
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
~~~

</div>
</details>

<details>
<summary>자동 페이징</summary>
<div markdown="1">

- 사용자가 스크롤을 시작하면 timer를 멈추고, 스크롤이 끝나면 timer 시작
~~~swift
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        stopTimer()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        startTimer()
    }
~~~
    
- 타이머 실행 블록에서 호출하는 코드
~~~swift
    self.collectionView.setContentOffset(.init(x: self.collectionView.contentOffset.x + self.cellWidth, y: self.collectionView.contentOffset.y)) 
    
~~~

</div>
</details>

</br>

## _HomeViewController.swift
- [1,2,3] 배열이 있다면, [3,1,2,3,1] 형태로 변경하고 처음과 끝 페이지로 왔을 때 스크롤 위치를 바꾸어 무한한 것처럼 보이게 함.
- 스크롤 시 cell subView의 origin.x 값을 변경하는 부분과 셀을 바꿔치기하는 부분이 중첩되어 깜빡이는 현상을 없애지 못함..
- [참고](https://ios-development.tistory.com/1197)
