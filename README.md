# Taşınabilir Zsh ayarları

Bu klasör mevcut etkin Zsh düzeninin HyDE gerektirmeyen sürümüdür. Oh My Zsh ile `git`, `sudo`, `zsh-256color`, `zsh-autosuggestions` ve `zsh-syntax-highlighting` eklentilerini kurar. Starship yüklüyse mevcut sistemdeki gibi onu kullanır; yoksa `robbyrussell` temasına döner. `bat`, `duf`, `eza`, `fzf` ve `fastfetch` ayarları ilgili programlar kuruluysa etkinleşir.

Yeni Linux bilgisayarda önce `git` ve `zsh` paketlerini kur. Sonra bu klasörde:

```sh
./install.sh
exec zsh
```

Betik mevcut `~/.zshenv`, `~/.zshrc` ve `~/.config/zsh` dosyalarını `~/.zsh-portable-backups/` altında saklar. Komut geçmişi, tamamlama önbelleği ve makineye özel HyDE ayarları bu klasöre dahil edilmedi. Önceki Powerlevel10k yapılandırması `zsh/.p10k.zsh` içinde referans olarak bulunur; etkin istem Starship’tir.

GitHub'a kendin yüklemek için bu klasörde `git init -b main`, `git add .` ve `git commit -m "Zsh ayarları"` çalıştır. GitHub'da bir depo oluşturup `git remote add origin <depo-adresi>` ve `git push -u origin main` ile gönder. Yeni bilgisayarda depoyu klonlayıp yukarıdaki kurulum komutlarını çalıştır.
