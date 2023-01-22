clc; clear; clf; close all force; hold on;
import fx_numbrs.* % Импорт функции с датасетом
digitsl = fx_numbrs'; % Присвоение переменной датасета
net = newhop(digitsl); % Создание сети Хопфилда
digits = num2cell(fx_numbrs,2); % разбивает содержимое на отдельные ячейки форма 10x1
% в каждой строке набор данных из датасета, от 0 до 9
bnw = [1 1 1; 0 1 0]; % RGB палитра 1 1 1 - белый, 0 1 0 - зелёный
% Вывод матрицы 3x4 с изображениями заложенными в датасете
for P = 1:10
    subplot(3,4,P); % Построение графика
    digit=digits{P}; % Обработка каждой цифры из датасета
    img = reshape(digit,7,9); % Reshape - позволяет преобразовать входной 
    % математический массив в другой массив, сохраняя при этом элементы исходных данных.
    image((img'+1)*255/2); % Отображать изображение из массива
    axis image %Установает ограничения оси и соотношения сторон
    axis off
    colormap(bnw) % Текущая цветовая карта графиков
    title(sprintf('Номер по счету: %d',P)); % Заголовок для каждого изображения
end
%%%%%%%%%
figure
for n = input('Напишите номер, от 1 до 10: ') % Ввод числа
    subplot(3,1,1) % Параметры построения графика
    digit_n = digitsl(:,n); % Выбор данных указанной цифры из массива
    picture = reshape(digit_n,7,9);
    image((picture'+1)*255/2);
    axis image
    axis off
    colormap(bnw)
    title(sprintf('Номер по счету: %d',n));
end
% Наложение шума
subplot(3,1,2)
%poshumim = digit_n + randi([-1,1],63,1); % Первая реализация шума, не
%стабильная
poshumim = digit_n; % Ввод новой переменной для работы с шумом
for k = 1:8 % Зашумленность, количество повторений наложения шума
    index = randi(63,1,k); % Гененрация чисел
    poshumim([index(k),index(k)])=+1;
    % Приравнивание рандомных чисел в матрице к +1 для создания шума
    % c помощью индексов
end
select_n=reshape(poshumim,7,9);
image((select_n'+1)*255/2);
axis image
axis off
colormap(bnw)
title(sprintf('Зашумленный образец "№ %d"', n))

% Запуск симуляции для удаления шума
subplot(3,1,3)
[Y,Pf,Af] = sim(net,{1,10},{},poshumim); % запуск сети Хопфилда
img=reshape(Y{10},7,9);
image((img'+1)*255/2);
axis image
axis off
colormap(bnw)
title(sprintf('"№ %d" образец, обработанный сетью Хопфилда', n))