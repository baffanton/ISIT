from PIL import Image
import os

directory = r"C:\Users\Антон\Desktop\Учеба\Гоша\dataset\train\star"
directory_new = r"C:\Users\Антон\Desktop\Учеба\Гоша\dataset\train\star_new"
object_name = "star"
i=0
for filename in os.listdir(directory):
   with open(os.path.join(directory, filename), 'r') as f: # open in readonly mode
      print(i)
      i += 1
      img = Image.open(directory + "\\" + filename)
      img = img.resize((200, 200))
      img = img.convert('RGB')
      img = img.save(directory_new + "\\" + object_name + str(i) + '.png')
      
