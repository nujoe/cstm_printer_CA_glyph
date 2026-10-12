# 프린터 설계 참조 파일

원작과 제조사 자료의 로컬 참조본이다. 새로운 X축·Q2299A 조합에 맞춘 완성 제작 도면이 아니다. 펌웨어는 실행하거나 복사하지 않는다.

## WorldPrinter

출처: [HomoFaciens WorldPrinter](https://homofaciens.de/technics-machines-WorldPrinter_en.htm), [원작 ZIP](https://homofaciens.de/download/WorldPrinter.zip), [헤드 회로 설명](https://homofaciens.de/technics-machines-printhead-hp6602_en.htm).

`worldprinter/`의 SCAD/STL 9개는 원본 ZIP에서 내용 변경 없이 보관한다. `head_circuit.jpg`는 ZIP의 `circuit.jpg`가 아니라 별도 헤드 회로 설명 페이지의 Figure9 참조본이다. 기어·롤러 지지·홀더의 치수와 시험 끼움에 사용한다. 커터, 구형 X축의 레일/벨트 지지, Pi/Uno 펌웨어와 C 실행 코드는 넣지 않는다.

| 파일 | 사용할 목적 |
| --- | --- |
| WorldPrinter.scad | 원작 치수와 고정 방식 참조 |
| printhead_mount.stl | Q2299A 쪽 P1 형상 참조. 새 캐리지 부착 검증 전 |
| stepper_mount_feed.stl | P2 급지 모터/하부 베어링 지지 |
| stepper_mount_feed_mirror.stl | P2 반대쪽 지지 |
| top_roller_mount.stl | 원작 P3 치수 참조. v21 낮은 프레임에서는 `../cad/P3_raised_guide_trial.stl`로 대체 |
| paper_roll_mount.stl | P5 지관 안의 베어링 지지 |
| paper_position.stl | P5 롤 축 위치 스페이서 |
| frame_link.stl | P6 15mm 각파이프 결합 |
| gears.stl | P7:25T1+60T1. 두 번 출력해 각2개. 별도70T는 포함하지 않음 |
| head_circuit.jpg | 원작 리본 접점 위치 RC01~RC16의 기준 그림 |

원본 파일의 존재를 곧바로 출력·조립 승인으로 해석하지 않는다. 본체 전체를 축소하면 베어링/모터/볼트 구멍도 달라지므로 전체 비율 축소는 하지 않는다. 2026-10-12 [HomoFaciens 저작권 안내](https://homofaciens.de/imprint_en.htm)의 무료 복사 허용을 확인했다. 원작자는 Norbert Heinz이며 위 출처와 원본 파일을 유지한다. 이 허용을 다른 제조사 자료의 라이선스로 적용하지 않는다.

## Bulk-Man 캐리지

출처: [선정 축 페이지](https://bulkman3d.com/product/v-slot-nema-17-linear-actuator/).

- [gantry_small.jpg](gantry_small.jpg): 65.5×65.5×3mm 도면.
- [gantry_large.jpg](gantry_large.jpg): 127×88×3mm 도면.
- [VS17B_exploded.jpg](VS17B_exploded.jpg): [제조사 분해 사진](https://bulkman3d.com/wp-content/uploads/2021/07/1-6.jpg).
- [VS17B_gantry_assembly.jpg](VS17B_gantry_assembly.jpg): [제조사 작은 캐리지 조립 사진](https://bulkman3d.com/wp-content/uploads/2021/07/1-2-1.jpg). 벨트 방향과 중앙 고정홀 배치 비교용.

두 치수 도면은 제조사 페이지의 `Small.jpg`, `Large-1.jpg`다. 추가 사진은2026-10-12에 보관했다. 주문 옵션의 출고 캐리지가 어느 쪽인지 보증하거나 사진만으로 정확한 간격을 측정하는 자료는 아니다. P1 홀 좌표를 벨트 방향 기준90도 회전해 대조했으며 캐리지 뒤 볼트/벨트 간격은 실제 키트와 대조한다.

## Panasonic G4 스위치

[AEQ_series_datasheet.pdf](AEQ_series_datasheet.pdf)는[DigiKey에 게시된 제조사 자료](https://mm.digikey.com/Volume0/opasdata/d220001/medias/docus/8850/sw_m_eng_aeq.pdf)를 내용 변경 없이 보관한 원문이다. 기준 모델·연결·시험 범위는[G4 선정표](../G4_INPUTS_v1_2026-10-12.md)를 따른다. 이 파일 확보만으로 장착 치수·핀 위치·실물 작동 검증이 끝난 것은 아니다.

## 사용자 FFC 상품 화면

[ffc_candidate_2026-10-12.png](ffc_candidate_2026-10-12.png)는2026-10-12 14:34:46 사용자 제공 화면의 원본 사본이다. 1.0mm/16P 옵션 선택을 확인하는 자료다. 이후 사용자가[AliExpress1005011914623154](https://ko.aliexpress.com/item/1005011914623154.html)의주소를 제공했다. 추적·장바구니·계정 매개변수는 보관하지 않는다. 실제 선택 보드의 치수·소켓 정격이나 배송 보증을 제공하는 자료는 아니다. [후보 해석](../HEAD_CONTACT_v1_2026-10-12.md)을 따른다.

[ffc_seller_ratings_2026-10-12.png](ffc_seller_ratings_2026-10-12.png)는15:45:52 사용자 사양 화면 원본 사본이다. SHA-256은 `bc3f8e69283f9395619c76689a97a05eccec43b736eb1448e06700bf2f5a55a4`다. `48V용`과`EU LVD 전압: 50Vac 또는75Vdc 이하`라는 판매자 표기를 읽을 수 있지만, 소켓 품번·인증서·접점 전류·허용 리본 두께·접점 면은 없다. AliExpress 직접 접근을 했거나 실제18V 사용을 승인했다고 표시하지 않는다.

[ffc_16p_soldered_candidate_2026-10-12.png](ffc_16p_soldered_candidate_2026-10-12.png)는15:51:55 사용자 제공 원본 사본이며[AliExpress1005012643948143](https://ko.aliexpress.com/item/1005012643948143.html)의 실제16P/1mm·납땜된2열8핀 헤더 사진을 포함한다. SHA-256은 `aec5efdac3445474938556e378237d3f0d98dc5d9a9af3326b0b36ff67ec585d`다. 선택Straight-16P-1PCS, 표시7,500원, 보드26x27mm/H1.6mm를읽었다. 소켓 제조사 정격·허용 리본 두께·Q2299A 실물 적합성을 확인한 자료는아니다. 자동생성AI 요약은제조사 자료로인용하지 않는다.

## 프린터Pi 전원 자료

[pi_27w_ko_kc_source.pdf](pi_27w_ko_kc_source.pdf)는[Raspberry Pi 게시한국KC 원문](https://pip-assets.raspberrypi.com/categories/900-approvals/documents/RP-006071-CF-1-rpi-27W-PSU%20South%20Korea%20KC%20Safety.pdf)의원본사본이다.1쪽의모델KO/파생KC·HU101296-24003·정격을렌더해대조했다. 판매후보608643의표시와맞지만실제수령라벨·현재인증취소/정지조회·전체DIY 프린터의인증을대신하지 않는다.

## MCD 분사 후보 모듈 자료

[MCD2803A-02_source.pdf](MCD2803A-02_source.pdf)는[태진기술 제조사 게시 원문](https://htckorea.co.kr/image/DK/MCD2803A-02_ULN2803A.pdf)의 사본이다. 2026-10-12 다운로드, 13쪽이며 모듈R1.1과 뒤쪽ULN2803A 자료를 포함한다. SHA-256은 `43e8664aa52e864656162bb4d0e27cd7cd389225d9ef31f5957974f46ca2e407`이다. 2쪽 회로의 C1/COM 부하 전원 연결을 렌더로 확인했으며 콘덴서 정격 전압은 기재되지 않았다. [검토 결과](../HEAD_TEST_v1_2026-10-11.md)에 따라18V 실물 사용 승인은 여전히 보류한다.

## P8 기성 지지부 제조사 치수

- [HFS5_brackets_source.pdf](HFS5_brackets_source.pdf): [미스미2019 미국 카탈로그](https://us.misumi-ec.com/pdf/fa/2019/2019_US_2700.pdf)의브래킷 치수와SET 구성. HBLSS5의폭14/다리20/두께3/Ø5.5·CBM5-8/HNTT5-5를렌더로대조했다.
- [HFS5_frames_source.pdf](HFS5_frames_source.pdf): [미스미2013 지역 카탈로그](https://sg.misumi-ec.com/pdf/fa/2013/p1839.pdf)의20/40mm HFS5 단면·6mm 홈·길이지정 범위. 한국2026년가격이나배송자료가아니다.
- 한국미스미 후속 옵션 견적에서 프로파일7개42,218원/브래킷20SET42,064원(VAT포함), 참고출하10/19·10/16을 확인했다. 상단일반가격`-`와 하단확정형번견적을 구분했다. [P8 선정 근거](../MECHANICAL_v1_2026-10-12.md#10-p8-간소화-비교안-별도-금속-프로파일-지지)를 따르며 도착 보증은 아니다.

자료는치수대조용이고프로파일/브래킷 구매·가공·전체구조 안전승인이나제조사CAD 재배포허가를뜻하지 않는다.
