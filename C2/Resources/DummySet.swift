//
//  DummySet.swift
//  C2
//
//  Created by YOOJUN PARK on 4/15/26.
//

import SwiftUI

let testData1 = ActivityData(
    tags: [.tennis, .morning],
    imageTitle: "아침에 하는 테니스",
    imageDescription: "중국의 우방과 전쟁하면서 중국을 방문하는 게 형식적으로 부적절할뿐 아니라 회담 성과에도 악영향을 미칠 것이라는 전망 때문이다.",
    imageData: [UIImage(named: "TestImage1")?.jpegData(compressionQuality: 0.8)].compactMap { $0 }
)
let testData2 = ActivityData(
    tags: [.running, .evening],
    imageTitle: "저녁에 하는 러닝",
    imageDescription: "구글의 첨단 메모리 압축 기술 '터보퀀트' 개발이 메모리 반도체 업계에 악재로 작용했지만 충격에서 조금씩 벗어나고 있습니다.",
    imageData: [UIImage(named: "TestImage1")?.jpegData(compressionQuality: 0.8)].compactMap { $0 }
)
let testData3 = ActivityData(
    tags: [.swimming, .morning],
    imageTitle: "아침 수영 대회",
    imageDescription: "현대차 계열사와 2차전지 등 일부 업종",
    imageData: [UIImage(named: "TestImage1")?.jpegData(compressionQuality: 0.8)].compactMap { $0 }
)
let testData4 = ActivityData(
    tags: [.surfing, .morning],
    imageTitle: "서핑을 아침에 함",
    imageDescription: "국제유가 벤치마크인 북해산 브렌트유 가격은 4% 오른 배럴당 106달러, WTI 즉 서부 텍사스유 가격은 3% 오른 93달러를 기록했습니다. 국내 원유 수입의 70%를 차지하는 중동산 두바이유 가격은 2% 내렸지만 배럴당 142달러로 여전히 높은 수준입니다.",
    imageData: [UIImage(named: "TestImage1")?.jpegData(compressionQuality: 0.8)].compactMap { $0 }
)
let testData5 = ActivityData(
    tags: [.surfing, .evening],
    imageTitle: "저녁에도 서핑함",
    imageDescription: "이란전쟁 발발 이후 코스피 시장에서 외국인 순매도는 3일 빼고 15일간 이뤄지고 있습니다.",
    imageData: [UIImage(named: "TestImage1")?.jpegData(compressionQuality: 0.8)].compactMap { $0 }
)
let testData6 = ActivityData(
    tags: [.surfing, .evening, .tennis],
    imageTitle: "저녁에도 서핑과 테니스함",
    imageDescription: "공관위는 부산시장 후보 자리를 놓고는 전재수 예비후보와 이재성 예비후보 간 경선을 치르기로 했다.",
    imageData: [UIImage(named: "TestImage1")?.jpegData(compressionQuality: 0.8)].compactMap { $0 }
)
let testData7 = ActivityData(
    tags: [.running, .swimming, .surfing],
    imageTitle: "러닝 수영 서핑 다 함",
    imageDescription: "조승래 사무총장은 당내에 후보자들의 비전을 둘러싼 토론을 거치는 것이 좋겠다는 판단이 있었고 후보자들의 경선에 대한 요청도 있었다며 두 분이 네거티브나 상대에 대한 비난보다는 부산의 어려운 미래에 대해 진단하고 정책과 비전을 갖고 경쟁하는 좋은 경선이 될 것이라고 보고 있다고 했다.",
    imageData: [UIImage(named: "TestImage1")?.jpegData(compressionQuality: 0.8)].compactMap { $0 }
)
let testData8 = ActivityData(
    tags: [.evening],
    imageTitle: "저녁임",
    imageDescription: "여러분께서 6전 7기에 도전하는 오 후보의 손을 잡아 주실 것을 간곡히 호소드린다",
    imageData: [UIImage(named: "TestImage1")?.jpegData(compressionQuality: 0.8)].compactMap { $0 }
)
