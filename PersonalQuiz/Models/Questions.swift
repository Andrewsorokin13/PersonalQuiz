import Foundation

struct Questions {
    let title: String
    let answerType: AnswerType
    let answers: [Answer]
    
    static func getQuestions() -> [Questions] {
        [
            Questions(
                title: "Какую пищу вы предпочитаете?",
                answerType: .single,
                answers: [
                    Answer(title: "Стейк", animal: .dog),
                    Answer(title: "Рыба", animal: .cat),
                    Answer(title: "Морковь", animal: .rabbit),
                    Answer(title: "Кукуруза", animal: .turtle)
                ]
            ),
            Questions(
                title: "Что вам нравится больше?",
                answerType: .multiple,
                answers: [
                    Answer(title: "Плавать", animal: .cat),
                    Answer(title: "Спать", animal: .dog),
                    Answer(title: "Обниматься", animal: .turtle),
                    Answer(title: "Есть", animal: .rabbit)
                ]
            ),
            Questions(
                title: "Любите ли вы поездки на машине?",
                answerType: .range,
                answers: [
                    Answer(title: "Ненавижу", animal: .rabbit),
                    Answer(title: "Нервничаю", animal: .turtle),
                    Answer(title: "Не замечаю", animal: .dog),
                    Answer(title: "Обожаю", animal: .cat)
                ]
            )
        ]
    }
}

struct Answer {
    let title: String
    let animal: Animal
}

enum AnswerType {
    case single
    case multiple
    case range
}

enum Animal: Character {
    case dog = "🐶"
    case cat = "🐱"
    case rabbit = "🐰"
    case turtle = "🐢"
    
    var description: String {
        switch self {
        case .dog:
            return "Вам нравится быть с друзьями. Вы окружаете себя людьми, которые вам нравятся и всегда готовы помочь."
        case .cat:
            return "Вы себе на уме. Любите гулять сами по себе. Вы цените одиночество."
        case .rabbit:
            return "Вам нравится все мягкое. Вы здоровы и полны энергии."
        case .turtle:
            return "Ваша сила - в мудрости. Медленный и вдумчивый выигрывает на больших дистанциях."
        }
    }
}
