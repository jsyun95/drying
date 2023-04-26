# drying
**Numerical method for predicting vertical particle distribution during drying process of colloidal film**  
**(콜로이드 필름의 건조 공정 간 수직 방향 입자 분포 예측 수치 계산법)**

**한국 저작권 위원회 등록**  
등록일: 2022년 10월 18일  
등록번호: 제 C-2022-039859 호  

- [소개](#소개)
- [설치](#설치)
- [주요기능](#주요기능)
- [사용법](#사용법)
- [개발](#개발)

# 소개

단분산 콜로이드 필름의 건조 공정 중 입자의 분포는 필름의 건조 속도와 입자의 확산의 비율인 Péclet number (Pe)에 의해서 결정이 됩니다. 낮은 Pe 영역에서는 필름의 건조 속도보다 입자의 확산이 우세하여 건조 중 필름 내 입자가 수직적으로 균일하게 분포하고, 높은 Pe 영역에서는 입자의 확산보다 필름의 건조 속도가 우세하여 중 건조 중 액체 계면에 입자가 축적되어 필름 내 입자의 수직적인 분포의 차이가 나타납니다.

본 프로그램은 고려대학교 화공생명공학과 정현욱 교수 연구진이 개발한 단분산 콜로이드 필름의 건조 중 수직 방향 입자 분포 예측 모델 (Yoo model) [1]을 수치해법으로 계산하는 MATLAB 코드를 제공합니다. 상기 모델은 두 가지 매개 변수를 새롭게 도입하여 빠른 건조 조건에서 입자의 농도 구배와 불균일성에 초점을 맞추고 있으며 기존의 시뮬레이션의 결과 [2]와 정성적으로 부합한다는 점에서 기존의 모델 (RZ model) [3]과 차별점이 있습니다. 상기 프로그램은 상기 모델을 통해서 입자의 초기 농도와 Pe에 따라 건조 중 입자의 수직적인 분포를 건조 시간에 따라서 효과적으로 예측할 수 있으며 기존의 모델과 용이하게 비교할 수 있습니다. 상기 프로그램은 초기 필름 두께, 공정 온도, 입자의 반지름, 입자의 초기 농도 (0.01-0.4) 그리고 용액의 점도 등 실제 공정 조건을 입력하여 사용할 수 있으며 넓은 범위의 건조 조건 (Pe=0.1-1500)에 대해서 사용할 수 있기 때문에 산업 현장에 적용하기 용이합니다.

[1] T. Yoo, B. Chun & H.W. Jung, Drying Technology, 40(3), 516-526 (2022)  
[2] B. Chun, T. Yoo & H.W. Jung, Soft Matter, 16, 523-533 (2020)  
[3] A. F. Routh and W. B. Zimmerman, Chemical Engineering Science, 59, 2961–2968 (2004)  


# 주요기능

1. 건조 공정 조건에 따른 입자의 수직적인 분포 해석
   - 필름 내 입자의 초기 농도의 영향
   - 건조 속도의 영향
   - 건조 공정 진행 간 입자의 수직적인 농도 구배 분석

2. 실제 공정 조건 반영
   - 초기 필름 두께
   - 공정 온도
   - 입자의 반지름
   - 입자의 초기 농도
   - 용액의 점도
   - 건조 속도

3. 기존 모델과의 비교
   - 넓은 범위의 건조 조건 (입자의 초기 농도 0.01-0.4, Pe=10-1500)에서 기존 모델과 비교


# 설치

drying code는 Matlab을 기반으로 작성되었으며 Matlab 외의 추가적인 모듈은 필요하지 않습니다.


# 사용법

본 프로그램은 다음의 네 가지 파일로 구성되어 있습니다.

1. input_variables.txt
2. Yoo_model_1D_drying.m
3. RZ_model_1D_drying.m
4. run_drying.m

파일 1은 공정의 초기 조건을 입력하는 파일입니다.  
건조 공정의 조건에 맞춰서 값을 입력하면 됩니다.

h0: Initial wet film thickness (초기 필름 두께)  
a: Particle radius (입자의 반지름)  
T: Process temperature (공정 온도)  
mu0: Dynamic viscosity of the solvent (용매의 점도)  
phi0: Initial concentration of the particle (입자의 초기 농도)  

파일 2는 새롭게 개발된 모델 (Yoo model)의 partial differential equation (PDE)를 계산하는 코드입니다.

파일 3은 기존 모델 (RZ model)의 PDE를 계산하는 코드입니다.

파일 4는 실행 파일입니다.

**[실행 방법]**

1. 네 가지 파일을 한 폴더에 저장합니다.  
2. 파일 1을 열어 공정 초기 조건을 입력합니다.  
3. MATLAB 프로그램을 이용하여 파일 4를 실행합니다.  
4. Péclet number (Pe)를 입력합니다.  
  Pe는 필름의 건조 속도와 입자의 확산속도의 비율로 다음과 같이 정의됩니다.  
  Pe = h0*v_ev/D0  
  h0: Initial wet film thickness  
  v_ev: Evaporation rate  
  D0: Stoke-Einstein diffusion coefficient  

5. model type을 입력합니다
  (1) Yoo model  
  (2) RZ model  

6. 선택한 모델을 사용해서 건조 중 필름 내 입자의 수직적인 분포를 출력합니다.


# 개발

본 패키지의 개발에는 별도의 프로그램을 필요로 하지 않습니다.    
Yoo model은 실험 결과로부터 파라미터를 수정하여 모델에 적용할 수 있습니다.
