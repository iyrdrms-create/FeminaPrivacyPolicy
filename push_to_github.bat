@echo off
setlocal

:: Nama repositori dan username berdasarkan gambar tadi
set GITHUB_USER=iyrdrms-create
set REPO_NAME=FeminaPrivacyPolicy
set REMOTE_URL=https://github.com/%GITHUB_USER%/%REPO_NAME%.git

echo ======================================================
echo  FEMINA PRIVACY POLICY - AUTO PUSH TO GITHUB
echo ======================================================
echo.

:: Pastikan kita berada di folder tempat file bat ini berada
cd /d "%~dp0"

:: Inisialisasi Git jika belum ada
if not exist ".git" (
    echo [1/5] Inisialisasi Git Lokal...
    git init
    git branch -M main
) else (
    echo [1/5] Git sudah terinisialisasi.
)

:: Cek apakah remote origin sudah ada
git remote get-url origin >nul 2>&1
if %errorlevel% neq 0 (
    echo [2/5] Menghubungkan ke Remote GitHub...
    git remote add origin %REMOTE_URL%
) else (
    echo [2/5] Remote origin sudah terhubung.
)

:: Menambahkan file
echo [3/5] Menambahkan perubahan file...
git add .

:: Commit dengan pesan otomatis menggunakan tanggal dan jam
set COMMIT_MSG="Auto Update: %date% %time%"
echo [4/5] Membuat Commit: %COMMIT_MSG%
git commit -m %COMMIT_MSG%

:: Push ke GitHub
echo [5/5] Mengunggah (Push) ke GitHub branch main...
echo.
git push -u origin main

if %errorlevel% equ 0 (
    echo.
    echo ======================================================
    echo  BERHASIL! Situs Anda sudah terupdate di GitHub.
    echo ======================================================
) else (
    echo.
    echo [!] TERJADI KESALAHAN saat push. 
    echo Pastikan koneksi internet aktif dan kredensial sudah benar.
)

echo.
pause
