import json

#
#Функции
#

#Функция для выбора исполняемой функции
def chooseQuestion(rule):
    global decision, questionNumber
    try:
        if checkHasNotAnswer(rule["question"]) == True:
            decision = 'Ответа нет'
            return
    except KeyError:
        pass
    match rule["callFunction"]:
        case "yesOrNo":
            questionNumber += 1
            return yesOrNo(rule["question"], rule["variable"], questionNumber)
        case "askValue":
            questionNumber += 1
            return askValue(rule["question"], rule["variable"], questionNumber)
        case "testValue":
            return testValue(rule["variable"])
        case "newValueForVariable":
            return newValueForVariable(rule["recordValue"], rule["variable"])

#Функция для выбора "Да" или "Нет"
def yesOrNo(question, variable, number):
    while True:
        answer = input(f'{number}. {question}: ')
        if answer != "Y" and answer != "N":
            print(f'ErrorMessage: Вы ответили не по правилам, попробуйте ещё раз!')
            continue
        if answer == "Y":
            Facts[variable] = "yes"
        if answer == "N":
            Facts[variable] = "no"
        break

#Функция для ввода числового значения
def askValue(question, variable, number):
    while True:
        answer = input(f'{number}. {question}: ')
        try:
            answer = int(answer)
            Facts[variable] = answer
            break
        except ValueError:
            print('ErrorMessage: Вы ввели не число, попробуйте ещё раз!')
            continue

#Функция для записи числового значения в переменную
def testValue(variable):
    value = int(Facts["countFilms"])
    Facts["countFilms"] = None
    if value > 2:
        Facts[variable] = ">2"
    else:
        Facts[variable] = "<2"

#Функция для получения нового значения для переменной
def newValueForVariable(recordValue, variable):
    Facts[variable] = recordValue

#Функция для проверки условий в правиле
def testRule(rule):
    for setCond in rule["conditions"]:
        inWork = True
        if 'not' in setCond:
            for cond in setCond["not"][0]:
                if setCond["not"][0][cond] == Facts[cond]:
                    inWork = False
            for cond in setCond:
                if cond != 'not':
                    if setCond[cond] != Facts[cond]:
                        inWork = False
        else:
            for cond in setCond:
                if setCond[cond] != Facts[cond]:
                    inWork = False
    return inWork

#Функция для проверки повтора вопроса
def checkHasNotAnswer(currQuestion):
    global questionVariable
    if currQuestion != questionVariable:
        questionVariable = currQuestion
        return False
    return True

#
#Основная часть
#
with open(r'JSON.json', encoding="utf-8") as file:
    dataFromJSONFile = json.load(file)
    print("Данные загружены!\n")

Facts = dataFromJSONFile["Facts"][0]
Rules = dataFromJSONFile["Rules"]
questionVariable = ''

decision = None
questionNumber = 0
print(f'Ответье на представленные вопросы:\nЕсли да, то ответ: Y\nЕсли нет, то ответ: N\n')

while decision is None:
    for rule in Rules:
        if testRule(rule):
            break
    chooseQuestion(rule)
    if decision is None:
        decision = Facts["decision"]

match decision:
    case "Ответа нет":
        print('Ответ не найден! Завершение программы...')
    case _:
        print(f"\nПосмотрите: {str(decision)}")
