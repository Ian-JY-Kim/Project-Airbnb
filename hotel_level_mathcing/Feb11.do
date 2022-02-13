cd "/Users/iankim/Library/Mobile Documents/com~apple~CloudDocs/data/airbnb/hotel_level_mathcing_feb11"


*1. Method 1and2로 붙은것들 저장
import delimited merged_by_1and2.csv, clear
drop v1
save temp1, replace


* 안붙은 458개만 남기기 
use hotel_population_20211102_493, clear
duplicates drop id_regist, force
merge 1:1 id_regist using temp1 
keep if _merge == 1
keep sigungu hotelname id_regist 
save hotel_left458, replace


* 458개에 위경도 붙여주기
import delimited hotel_location_google.csv, clear
drop address
save hotel_location_google, replace

use hotel_left458, clear
merge 1:1 id_regist using hotel_location_google
keep if _merge == 3
drop _merge 
save hotel_left458, replace



*2. Method 3 붙은것들 저장
* 지도로 붙인 것들 붙여주기 --> 12개만 추가로 붙음
import delimited intersection_100X100.csv, clear
keep id_regist
gen yes = 1
save gis_temp, replace

use hotel_left458, clear
merge 1:1 id_regist using gis_temp
keep if _merge == 1
drop _merge
drop yes
save hotel_left446, replace
export delimited using hotel_left456, replace



use hotel_population_20211102_493, clear
duplicates drop id_regist, force
keep id_regist address sido
save temp, replace

use hotel_left446, clear
merge 1:1 id_regist using temp
keep if _merge == 3
drop _merge
gen hotelname2 = sido + hotelname
export delimited using hotel_left446, replace




*3. Method 4 붙은 것들 저장
import delimited hotel_446_naver.csv, clear
save hotel_446_naver, replace  // --> merged_by_naver
tab naver_rate
keep if naver_rate == "Multiple"








*4. 일단 붙은 것
import delimited merged_by_naver.csv, clear
save merged_by_naver, replace
import delimited merged_by_upto3.csv, clear
keep id_regist 결정등급
append using merged_by_naver
save merged_Feb11, replace





*5. 안 붙은 것 내보내기
use hotel_population_20211102_493, clear
duplicates drop id_regist, force
merge 1:1 id_regist using merged_Feb11

keep if _merge == 1
drop _merge
save hotel_population_20211102_298, replace
export delimited using hotel_population_20211102_298, replace




*6. 눈으로 붙인 것 붙여주기 --> 7개
import delimited hotel_left_298_eyeballing.csv, clear
tab v4
keep if v4 != ""
drop 결정등급 
rename v4 결정등급
keep id_regist 결정등급
save eyeballing_result, replace
 
use merged_Feb11, clear 
append using eyeballing_result
unique id_regist
save merged_Feb11_final, replace
 

 
 
*7. Multiple 인 애들 눈으로 붙여주기
import delimited hotel_446_naver.csv, clear
keep if naver_rate == "Multiple"
export delimited using naver_rate_multiple, replace
// 눈으로 작업 했고
import delimited naver_rate_multiple_eyeballing, clear
keep if 결정등급 != ""
export delimited using naver_left_eyeballing, replace
keep id_regist 결정등급
order id
save naver_left_temp, replace

use merged_Feb11, clear
append using naver_left_temp

save merged_Feb11_final, replace




* 오동재 한옥 호텔 남기기
use hotel_population_20211102_493, clear
keep if hotelname == "한옥호텔 오동재"
keep id_regist
gen 결정등급 = "3성급"
save odongjae, replace






use merged_Feb11_final, clear
append using odongjae
save merged_Feb11_final, replace
