
clc; clear; close all;

%%% Pelatihan 
% menetapkan lokasi folder data latih
nama_folder = 'data latih';
% membaca nama file yang berformat jpg
nama_file = dir(fullfile(nama_folder,'*.jpg'));
% menghitung jumlah file yang dibaca
jumlah_file = numel(nama_file);
% menginisialisasi variabel ciri_h, ciri_s, dan kelas_buah
ciri_h = zeros(jumlah_file,1);
ciri_s = zeros(jumlah_file,1);
kelas_buah = cell(jumlah_file,1);
% melakukan ekstraksi ciri terhadap seluruh file yang dibaca
for n = 1:jumlah_file
    % membaca file citra
    Img = imread(fullfile(nama_folder,nama_file(n).name));
    % mengkonversi ruang warna citra rgb menjadi L*a*b
    cform = makecform('srgb2lab');
    lab = applycform(Img,cform);
    % mengekstrak komponen b dari citra L*a*b
    b = lab(:,:,2);
    % melakukan thresholding terhadap komponen b
    %bw = b>110; %edited
    bw=im2bw(Img,0.80);
    
    % melakukan operasi morfologi untuk menyempurnakan hasil segmentasi
    %bw = imfill(bw,'holes'); %edited
    bw=imfill(1-bw,'holes');
    
    % mengkonversi ruang warna citra rgb menjadi hsv
    hsv = rgb2hsv(Img);
    % mengekstrak komponen h dan s
    h = hsv(:,:,1);
    s = hsv(:,:,2);
    % mengubah nilai background menjadi nol
    h(~bw) = 0;
    s(~bw) = 0;
    % menghitung rata-rata nilai hue dan saturation
    ciri_h(n) = mean(mean(h));
    ciri_s(n) = mean(mean(s));
end

% menetapkan kelas target latih
for n = 1:10
    kelas_buah{n} = 'mengkudu';
end

for n = 11:jumlah_file
    kelas_buah{n} = 'sirsak';
end

% menampilkan sebaran data latih
figure;
h1 = gscatter(ciri_h,ciri_s,kelas_buah,'rb','v^',[],'off');
set(h1,'LineWidth',2)
axis([0 0.6 0 0.6])
xlabel('hue')
ylabel('saturation')
legend('mengkudu (latih)','sirsak (latih)','Location','SE')
title('{\bf Sebaran data latih}')

% menentukan garis batas berdasarkan penghitungan linear discriminant
% analysis
figure;
h1 = gscatter(ciri_h,ciri_s,kelas_buah,'rb','v^',[],'off');
set(h1,'LineWidth',2)
xlabel('hue')
ylabel('saturation')

[X,Y] = meshgrid(linspace(0,0.6),linspace(0,0.6));
X = X(:); Y = Y(:);
[C,err,P,logp,coeff] = classify([X Y],[ciri_h,ciri_s],...
    kelas_buah,'Linear');

hold on;
gscatter(X,Y,C,'rb','.',1,'off');
K = coeff(1,2).const;
L = coeff(1,2).linear;
f = @(x,y) K + [x y]*L;

h2 = ezplot(f,[0 0.6 0 0.6]);
set(h2,'Color','y','LineWidth',2)
axis([0 0.6 0 0.6])
xlabel('hue')
ylabel('saturation')
legend('mengkudu (latih)','sirsak (latih)','daerah mengkudu (latih)',...
    'daerah sirsak (latih)','garis batas','Location','SE')
title('{\bf Klasifikasi buah mengkudu dan sirsak (pelatihan)}')

% melakukan fitting linear discriminant analysis
obj = fitcdiscr([ciri_h,ciri_s],kelas_buah);

% menyimpan variabel obj
save obj obj

% menampilkan sebaran data latih dan data uji
figure;
h1 = gscatter(ciri_h,ciri_s,kelas_buah,'rb','v^',[],'off');
set(h1,'LineWidth',2)
xlabel('hue')
ylabel('saturation')

[X,Y] = meshgrid(linspace(0,0.6),linspace(0,0.6));
X = X(:); Y = Y(:);
[C,err,P,logp,coeff] = classify([X Y],[ciri_h,ciri_s],...
    kelas_buah,'Linear');

hold on;
gscatter(X,Y,C,'rb','.',1,'off');
K = coeff(1,2).const;
L = coeff(1,2).linear;
f = @(x,y) K + [x y]*L;

h2 = ezplot(f,[0 0.6 0 0.6]);
set(h2,'Color','y','LineWidth',2)
axis([0 0.6 0 0.6])

%%% Pengujian
% menetapkan lokasi folder data uji
nama_folder = 'data uji';
% membaca nama file yang berformat jpg
nama_file = dir(fullfile(nama_folder,'*.jpg'));
% menghitung jumlah file yang dibaca
jumlah_file = numel(nama_file);
% menginisialisasi variabel ciri_h, ciri_s, dan kelas_buah
ciri_h = zeros(jumlah_file,1);
ciri_s = zeros(jumlah_file,1);
kelas_buah = cell(jumlah_file,1);
% melakukan ekstraksi ciri terhadap seluruh file yang dibaca
for n = 1:jumlah_file
    % membaca file citra
    Img = imread(fullfile(nama_folder,nama_file(n).name));
    % mengkonversi ruang warna citra rgb menjadi L*a*b
    cform = makecform('srgb2lab');
    lab = applycform(Img,cform);
    % mengekstrak komponen b dari citra L*a*b
    b = lab(:,:,2);
    % melakukan thresholding terhadap komponen b
    %bw = b>110; %edited
    bw=im2bw(Img,0.80);
    % melakukan operasi morfologi untuk menyempurnakan hasil segmentasi
    %bw = imfill(bw,'holes'); %edited
    bw = imfill(1-bw,'holes'); 
    % mengkonversi ruang warna citra rgb menjadi hsv
    hsv = rgb2hsv(Img);
    % mengekstrak komponen h dan s
    h = hsv(:,:,1);
    s = hsv(:,:,2);
    % mengubah nilai background menjadi nol
    h(~bw) = 0;
    s(~bw) = 0;
    % menghitung rata-rata nilai hue dan saturation
    ciri_h(n) = mean(mean(h));
    ciri_s(n) = mean(mean(s));
end

% menetapkan kelas target uji
for n = 1:8
    kelas_buah{n} = 'mengkudu';
end

for n = 9:jumlah_file
    kelas_buah{n} = 'sirsak';
end

% mengujikan data uji sesuai dengan garis batas yang terbentuk
label = predict(obj,[ciri_h,ciri_s]);

% menampilkan sebaran data latih dan data uji
hold on
h3 = gscatter(ciri_h,ciri_s,label,'gm','v^',[],'off');
set(h3,'LineWidth',2)
xlabel('hue')
ylabel('saturation')
legend('mengkudu (latih)','sirsak (latih)','daerah mengkudu (latih)',...
    'daerah sirsak (latih)','garis batas','mengkudu (uji)','sirsak (uji)',...
    'Location','SE')
title('{\bf Klasifikasi buah mengkudu dan sirsak (pengujian)}')

% menghitung nilai akurasi pengujian
jumlah_benar = 0;
for n = 1:jumlah_file
    if isequal(label{n},kelas_buah{n})
        jumlah_benar = jumlah_benar+1;
    end
end

akurasi = jumlah_benar/jumlah_file*100;
disp(['akurasi = ',num2str(akurasi),' %'])