import yaml

listItems = []
with open('code.yaml', encoding="utf8") as fh:
    dictionary_data = yaml.safe_load(fh)
    for k, v in dictionary_data.items():
        listItems.append(v)

listKey = []
for k in range(len(listItems)):
    for kk, vv in listItems[k].items():
        if (kk == 'source'):
            check = vv in listKey
            if (check == False):
                listKey.append(vv)


print('СПИСОК РОДИТЕЛЕЙ:')
for i in listKey:
    print(i)
parent = input("/./Выберите родителя из списка: ")
print()

listQuestion = []
for k in range(len(listItems)):
    nextIsQuest = False
    for kk, vv in listItems[k].items():
        if (vv == parent):
            nextIsQuest = True
            continue
        if (nextIsQuest == True):
            listQuestion.append(vv)
            break

print("СПИСОК ВОПРОСОВ: ")
for i in listQuestion:
    print(i)
question = input("/./Выберите вопрос из списка: ")
print()

for k in range(len(listItems)):
    nextIsQuest = False
    nextIsAnswer = False
    for kk, vv in listItems[k].items():
        if (vv == parent):
            nextIsQuest = True
            continue
        if (nextIsQuest == True and vv == question):
            nextIsAnswer = True
            continue
        if (nextIsAnswer == True):
            answer = vv
            break

print("ОТВЕТ:")
if (type(answer) == list):
    for i in answer:
        print(i)
else:
    print(answer)
        
