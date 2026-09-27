# Kendi alias, export ve fonksiyonlarını buraya ekle.

if [[ -o interactive ]] && command -v fastfetch >/dev/null 2>&1; then
    if [[ "$TERM" == *kitty* ]]; then
        fastfetch --logo-type kitty
    else
        fastfetch
    fi
fi
