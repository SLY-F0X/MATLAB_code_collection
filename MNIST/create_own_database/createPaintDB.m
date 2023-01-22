images=dir('*.png'); % Из директории запуска ищет все файлы с расширением png
for i=1:length(images) % Цикл чтения картинок по их количеству
    picture = strcat(images(i).name); % получение каждой картинки
    picture = imread(picture); % Чтение файла
    picture = im2gray(picture); % Пребразование в оттенки серого
    picture = im2double(picture); % Преобразование в тип данных double
    picture = reshape(picture,784,1); % Преобразование в матрицу вида 28*28=784 x 1
    database_paint(:, i) = picture; % Запись в матрицу результатов формата 784 x количество картинок
end
