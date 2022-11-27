using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Linq;

namespace _5LabWork
{
    internal class Program
    {
        //1 - относительное большинство
        //2 - борда
        static int variant;
        static void Main(string[] args)
        {
            //
            //1. Выбор метода
            //

            while (true)
            {
                Console.Write("Какой метод хотите рассмотреть?" + '\n' + "1 - Метод относительного большинства;" + '\n' + "2 - Метод Борда." + '\n' + "Ваш выбор: ");
                int znach = Convert.ToInt32(Console.ReadLine());
                if (znach != 1 && znach != 2)
                {
                    Console.Clear();
                    continue;
                }
                variant = znach;
                break;
            }

            //
            //2. Ввод данных
            //

            Console.Clear();
            Console.WriteLine("Отлично! Теперь необходимо ввести дополнительные данные:" + '\n' + "n - количество вариантов голосования;" + '\n' + "m - количество голосующих." + '\n');
            Console.Write("n = ");
            int n = Convert.ToInt32(Console.ReadLine());
            Console.Write("m = ");
            int m = Convert.ToInt32(Console.ReadLine());

            //
            //3. Заполнение голосования
            //

            Console.Clear();
            int[,] mas = new int[m, n];
            Console.WriteLine("Info: Сейчас будем заполнять голосующих в виде: голосующий и его вариант голосования" + '\n');
            for (int i = 0; i < m; i++)
            {
                Console.WriteLine($"Заполняем {i + 1}-го голосующего!");
                for (int j = 0; j < n; j++)
                {
                    Console.Write($"На {j + 1}-ое место поставлен: ");
                    int newZnach = Convert.ToInt32(Console.ReadLine());
                    for (int s = 0; s < n; s++)
                    {
                        if (mas[i, s] == newZnach)
                        {
                            Console.WriteLine("Error: Вы поставили этого человека на другое место. Попробуйте снова!");
                            j -= 1;
                            continue;
                        }
                    }
                    mas[i, j] = newZnach;
                }
                Console.WriteLine();
            }

            //
            //4. Вывод матрицы выборов
            //

            Console.Clear();
            Console.WriteLine("Матрица выборов:");
            for (int i = 0; i < m; i++)
            {
                for (int j = 0; j < n; j++)
                {
                    Console.Write(mas[i, j]);
                    Console.Write('\t');
                }
                Console.WriteLine();
            }
            Console.WriteLine();

            //
            //Подсчет результатов в зависимости от выбранного метода
            //

            int[] masItog = new int[n];

            switch (variant)
            {
                case 1:
                    masItog = RelativeMajority(n, m, mas);
                    break;
                case 2:
                    masItog = MetodBorda(n, m, mas);
                    break;
                default:
                    Console.WriteLine("Результата нет!");
                    break;
            }

            //
            //Вывод результатов
            //

            Console.WriteLine("Результаты: ");
            for (int i = 0; i < n; i++)
            {
                Console.WriteLine($"{i + 1}-ый участник набрал {masItog[i]} баллов!");
            }

            //
            //Результаты выборов
            //

            int maxValue = masItog.Max();
            int maxIndex = 0;
            int countMax = 0;
            for (int i = 0; i < n; i++)
            {
                if (masItog[i] == maxValue)
                {
                    maxIndex = i;
                    countMax++;
                }
                if (countMax > 1)
                {
                    Console.WriteLine($"Несколько участников набрали {maxValue} баллов. Голосование не пройдено!");
                    break;
                }
                if (i == n - 1)
                {
                    Console.WriteLine($"Победил {maxIndex + 1} участник. Количество баллов: {maxValue}!");
                }
            }
            Console.ReadKey();
        }

        static int[] MetodBorda(int n, int m, int[,] mas)
        {
            Console.WriteLine("Вы выбрали Метод Борда!");
           
            int[] masItog = new int[n];

            for (int c = 0;c < n;c++)
            {
                for (int i = 0; i < m; i++)
                {
                    for (int j = 0; j < n; j++)
                    {
                        if (mas[i, j] == c + 1)
                        {
                            masItog[c] += (n - 1) - j;
                        }
                    }
                }
            }

            return masItog;
        }

        static int[] RelativeMajority(int n, int m, int[,] mas)
        {
            Console.WriteLine("Вы выбрали Метод относительного большинства!");

            int[] masItog = new int[n];

            for (int c = 0;c < n;c++)
            {
                for (int i = 0;i < m;i++)
                {
                    int currFirstElem = mas[i, 0];
                    if (currFirstElem == c + 1)
                    {
                        masItog[c]++;
                    }
                }
            }

            return masItog;
        }
    }
}
