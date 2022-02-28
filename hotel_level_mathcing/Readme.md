
   

# Used Data Description
1. hotel_population_20211102_493.dta: 
    - 기존의 데이터에서 호텔 등급 붙어 있지 않은 493개의 호텔로 구성  
    - (where 기존의 데이터: hotel_origin1224.dta --> 1374 hotels are there)  
2. korea_hotel_govnt.csv: 
    - 2월 8일에 내려받은, 한국관광협회중앙회_호텔업등급결정현황_20220208 자료에 위경도 geocoding 해서 붙인 자료




# Task
- 2에는 있는데, 1에는 없는 호텔 등급 정보 가져와서 1에 붙여주기




# Methods
1. 호텔 이름으로 붙이기        
2. 호텔 전화번호로 붙이기  
3. 호텔 위치로 붙이기
4. 네이버 Scraping
5. 안되는 것들은 육안으로 붙이기
6. 네이버 Scraping 코드에서 검색 결과 다중으로 떠서 Drop 했던 자료 손으로 검색해서 붙이기
7. 체인 호텔 육안으로 솎아내서 임의로 붙이기

- 1, 2는 python 코드로 실행 
- 3은 QGIS에서 
    - 두 데이터 셋 모두 위경도 찍어서 지도에 올림
    - 두 데이터 셋 모두 반경 30m 설정해서 버퍼 그림
    - 버퍼 겹치기 실행 --> 겹치는 버퍼가 같은 호텔 명 갖고 있는지 확인

<img src="https://user-images.githubusercontent.com/87853188/153698001-808ae6d0-62ed-4e0b-9f1b-b9c505244276.png" width="400" height="400"/>

- eg. 주황색: 1번 자료 반경 100 , 보라색: 2번 자료 반경 30 


![image](https://user-images.githubusercontent.com/87853188/153700978-aba6b94d-61e1-4242-a6fe-4929fec13b50.png)
- 네이버 호텔 등급 정보는 호텔 등급 결정 사무국 자료에 기반함

<img width="453" alt="image" src="https://user-images.githubusercontent.com/87853188/153735969-8f4cecbc-4d06-4e8d-9b8a-053ee52c66ad.png">
- 네이버 검색 결과 예시
<img width="624" alt="image" src="https://user-images.githubusercontent.com/87853188/153735983-41a33187-f0ad-486d-8385-e73bb8a16de6.png">
- 관광협회 자료 

# Results
- 1번 2번 방법으로 34개 붙음   : merged_by_1and2.csv
- 3번 방법으로 12개 붙음      : merged_by_3.csv
- 4번 방법으로 148개 붙음     : merged_by_naver.csv   (네이버에서 가져온 자료는 '성급' 호칭을 씀)  
- 5번 방법으로 7개 붙음       : hotel_left_298_eyeballing.csv
- 6번 방법으로 27개 붙음      : naver_left_eyeballing.csv (자료에는 26개 존재, 추가적으로 5번 과정에서는 붙지 않았던 오동재 한옥 호텔 6번 과정에서 발견해서 손으로 붙여줌)
- 7번 방법으로 10개 붙음      : chain_eyeballing.dta
- <b>merged_Feb28_final.dta</b> 위의 방법으로 붙은 238개 호텔 자료
