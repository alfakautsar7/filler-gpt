#!/bin/bash

# Pastikan semua argumen terpenuhi
if [ "$#" -ne 4 ]; then
    echo "Usage: $0 <local_dir> <commit_message> <repo_url> <personal_access_token>"
    exit 1
fi

# Argumen
LOCAL_DIR=$1
COMMIT_MSG=$2
REPO_URL=$3
PAT=$4

# Navigasi ke direktori lokal
cd "$LOCAL_DIR" || { echo "Direktori tidak ditemukan: $LOCAL_DIR"; exit 1; }

# Inisialisasi git jika belum diinisialisasi
if [ ! -d ".git" ]; then
    git init
    git remote add origin "${REPO_URL}"
fi

# Tambahkan file dan commit
git add .
git commit -m "$COMMIT_MSG"

# Tambahkan token PAT ke URL
AUTHENTICATED_URL=$(echo "$REPO_URL" | sed "s|https://|https://${PAT}@|")

# Push ke repository
git branch -M main
git push -u "$AUTHENTICATED_URL" main
