# MUSINSA-banner-CloneCoding
#Carousel CollectionView #Infinite CollectionView

![Mar-13-2023 14-36-27](https://user-images.githubusercontent.com/94464179/224616704-805d5dff-59a5-4935-8ad3-fed299f57935.gif)




## HomeViewController.swift
- 콜렉션뷰의 numberOfItems를 Int.Max로 잡고 유효한 페이지 숫자를 계산해서 보여줌.


## _HomeViewController.swift
- [1,2,3] 배열이 있다면, [3,1,2,3,1] 형태로 변경하고 처음과 끝 페이지로 왔을 때 스크롤 위치를 바꾸어 무한한 것처럼 보이게 함.
- 콜렉션뷰 스크롤 시 cell subView의 origin.x 값을 변경하는 부분과 셀을 바꿔치기하는 부분이 중첩되어 깜빡이는 현상을 없애지 못하여 사용 불가..
- [참고](https://ios-development.tistory.com/1197)
