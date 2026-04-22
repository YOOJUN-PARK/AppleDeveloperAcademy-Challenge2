//
//  DummySet.swift
//  C2
//
//  Created by YOOJUN PARK on 4/15/26.
//

import SwiftUI

let testData1 = ActivityData(
    timeSlot: .morning,
    tag: .tennis,
    imageTitle: "함께하는 테니스 레슨 모임",
    imageDescription: "주로 주말 오전 다같이 모여 자세 교정을 포함한 레슨을 진행합니다. 기숙사 아래 C,D 코트로 오시면 됩니다~!",
    imageData: [UIImage(named: "Image1")?.jpegData(compressionQuality: 0.8)].compactMap { $0 }
)
let testData2 = ActivityData(
    timeSlot: .evening,
    tag: .tennis,
    imageTitle: "코트 빌려서 친구랑 2시간 내리 침",
    imageDescription: "오랜만에 쳤더니 온몸이 뻐근하네요. 역시 테니스는 중독성이 있어요.",
    imageData: [UIImage(named: "Image2")?.jpegData(compressionQuality: 0.8)].compactMap { $0 }
)
let testData3 = ActivityData(
    timeSlot: .evening,
    tag: .running,
    imageTitle: "드디어 하프 마라톤 완주했습니다",
    imageDescription: "1시간 58분. 2시간 안에 들어오는 게 목표였는데 해냈어요 ㅠㅠ",
    imageData: [UIImage(named: "Image3")?.jpegData(compressionQuality: 0.8)].compactMap { $0 }
)
let testData4 = ActivityData(
    timeSlot: .morning,
    tag: .running,
    imageTitle: "올림픽공원 10km 새벽 러닝",
    imageDescription: "요즘 매일 아침 6시에 일어나서 뛰고 있는데 한 달째 유지 중입니다. 처음엔 3km도 힘들었는데 몸이 달라진 게 느껴져요.",
    imageData: [UIImage(named: "Image4")?.jpegData(compressionQuality: 0.8)].compactMap { $0 }
)
let testData5 = ActivityData(
    timeSlot: .evening,
    tag: .running,
    imageTitle: "퇴근하고 한강 5km 뛰었습니다",
    imageDescription: "요즘 스트레스 풀려고 달리기 시작했는데 진짜 도움이 되는 것 같아요.",
    imageData: [UIImage(named: "Image5")?.jpegData(compressionQuality: 0.8)].compactMap { $0 }
)
let testData6 = ActivityData(
    timeSlot: .morning,
    tag: .swimming,
    imageTitle: "100일째 새벽 수영 출석 성공",
    imageDescription: "작년 겨울부터 시작해서 오늘로 딱 100일 개근했습니다. 처음엔 25m도 못 갔는데 이제 1km 연속으로 완주해요. 꾸준함이 답인 것 같아요.",
    imageData: [UIImage(named: "Image6")?.jpegData(compressionQuality: 0.8)].compactMap { $0 }
)
let testData7 = ActivityData(
    timeSlot: .morning,
    tag: .hiking,
    imageTitle: "올해 목표였던 한라산 백록담 드디어 찍었다",
    imageDescription: "새벽 4시에 출발해서 8시간 걸렸네요. 정상에서 먹은 컵라면이 진짜 인생 라면이었습니다.",
    imageData: [UIImage(named: "Image7")?.jpegData(compressionQuality: 0.8)].compactMap { $0 }
)
let testData8 = ActivityData(
    timeSlot: .evening,
    tag: .hiking,
    imageTitle: "관악산 야간 산행 완료",
    imageDescription: "헤드랜턴 끼고 올라갔는데 정상에서 보이는 서울 야경이 장관이었습니다. 조금 무서웠지만 그만한 가치가 있었어요.",
    imageData: [UIImage(named: "Image8")?.jpegData(compressionQuality: 0.8)].compactMap { $0 }
)
let testData9 = ActivityData(
    timeSlot: .evening,
    tag: .surfing,
    imageTitle: "서핑 처음 배웠는데 보드 위에 섰어요!!",
    imageDescription: "양양 입문 클래스 다녀왔습니다. 강사님이 잘 가르쳐 주셔서 첫날에 일어서는 데 성공했어요. 다음 주에 또 가야겠다.",
    imageData: [UIImage(named: "Image9")?.jpegData(compressionQuality: 0.8)].compactMap { $0 }
)
let testData10 = ActivityData(
    timeSlot: .morning,
    tag: .surfing,
    imageTitle: "제주도 서핑 3일 후기",
    imageDescription: "오전 일찍 파도가 제일 좋다는 말이 맞더라고요. 매일 아침 6시에 바다 나갔습니다. 실력이 확 는 느낌이에요.",
    imageData: [UIImage(named: "Image10")?.jpegData(compressionQuality: 0.8)].compactMap { $0 }
)
let testData11 = ActivityData(
    timeSlot: .evening,
    tag: .surfing,
    imageTitle: "부산 송정 파도 진짜 좋았다",
    imageDescription: "저녁 노을 지는 시간에 탔는데 뷰가 미쳤어요. 파도도 딱 적당해서 너무 좋았습니다.",
    imageData: [UIImage(named: "Image11")?.jpegData(compressionQuality: 0.8)].compactMap { $0 }
)
let testData12 = ActivityData(
    timeSlot: .morning,
    tag: .bicycle,
    imageTitle: "인천 - 서울 자출 완료",
    imageDescription: "왕복 말고 편도만 했는데도 허벅지가 터질 것 같네요. 그래도 해냈다는 게 뿌듯합니다.",
    imageData: [UIImage(named: "Image12")?.jpegData(compressionQuality: 0.8)].compactMap { $0 }
)
let testData13 = ActivityData(
    timeSlot: .evening,
    tag: .gym,
    imageTitle: "스쿼트 100kg 오늘 처음 성공",
    imageDescription: "6개월 목표였는데 4개월 만에 달성했습니다. 폼 잡는 게 제일 힘들었어요. 같이 운동하는 형 덕분에 해낸 것 같습니다 ㅎㅎ",
    imageData: [UIImage(named: "Image13")?.jpegData(compressionQuality: 0.8)].compactMap { $0 }
)
let testData14 = ActivityData(
    timeSlot: .morning,
    tag: .pingpong,
    imageTitle: "탁구 동호회 첫 참가 후기",
    imageDescription: "동네 탁구장 동호회에 처음 나갔습니다. 다들 엄청 잘 치시는데 그래도 친절하게 맞춰주셔서 재밌었어요. 매주 토요일 오전에 모인다고 하니 계속 나가볼 생각입니다.",
    imageData: [UIImage(named: "Image14")?.jpegData(compressionQuality: 0.8)].compactMap { $0 }
)
let testData15 = ActivityData(
    timeSlot: .evening,
    tag: .pingpong,
    imageTitle: "탁구 대회 나가서 8강 진출했습니다",
    imageDescription: "구청 주최 생활체육 대회였는데 생각보다 훨씬 수준이 높더라고요. 그래도 8강까지 올라간 거 만족합니다. 내년엔 4강 목표.",
    imageData: [UIImage(named: "Image15")?.jpegData(compressionQuality: 0.8)].compactMap { $0 }
)
let testData16 = ActivityData(
    timeSlot: .morning,
    tag: .pingpong,
    imageTitle: "오전 탁구 1시간, 칼로리 소모 장난 아니네요",
    imageDescription: "가볍게 치는 줄 알았는데 땀이 엄청 나요. 탁구가 이렇게 운동량이 많은 줄 몰랐습니다.",
    imageData: [UIImage(named: "Image16")?.jpegData(compressionQuality: 0.8)].compactMap { $0 }
)
let testData17 = ActivityData(
    timeSlot: .evening,
    tag: .badminton,
    imageTitle: "사내 배드민턴 대회 준우승",
    imageDescription: "결승에서 졌지만 나름 만족합니다. 내년엔 우승 노려볼게요.",
    imageData: [UIImage(named: "Image17")?.jpegData(compressionQuality: 0.8)].compactMap { $0 }
)
let testData18 = ActivityData(
    timeSlot: .morning,
    tag: .gym,
    imageTitle: "벤치프레스 3개월 만에 20kg 늘었습니다",
    imageDescription: "처음엔 60kg도 버거웠는데 오늘 80kg 3세트 성공했어요. 식단이랑 수면 관리 병행한 게 도움이 된 것 같습니다.",
    imageData: [UIImage(named: "Image18")?.jpegData(compressionQuality: 0.8)].compactMap { $0 }
)
