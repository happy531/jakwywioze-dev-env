## Instalacja
### MacOS
```console
./install_mac.sh
```
### Windows
```console
./install_windows.bat
```

Skrypty zaciągają poniższe repozytoria
[Backend](https://github.com/happy531/jakwywioze-backend)
[Frontend](https://github.com/szymonbartanowicz/jakwywioze-frontend)
[Web-crawler](https://github.com/inoasasyn/Jakwywioze_web_crawler)

Ostatnie nie jest wymagane do uruchomienia aplikacji.

## Wymagania przed uruchomieniem
### Docker
Aby uruchomić apliklacje lokalnie wymagany jest Docker Desktop.

[Download Docker Desktop](https://www.docker.com/get-started)

### Klucz API do Geocoding
[Rapid Api - TrueWay Geocoding](https://rapidapi.com/trueway/api/trueway-geocoding)

Następnie w `docker-compose-dev.yml` i `docker-compose-prod.yml`
```text
- GEOCODING_API_KEY=twoj_klucz_api
```
### Konto Gmail
Do modułu rejestracji wymagane jest konto Gmail, z którego będą przychodzić linki z potwierdzeniem konta i resetem hasła.
[Gmail - konto](https://support.google.com/mail/answer/56256?hl=en)

Następnie w `docker-compose-dev.yml` i `docker-compose-prod.yml`
```text
- EMAIL=twoj_gmail@gmail.com
- PASSWORD=twoje_haslo_gmail
```

## Uruchamianie lokalnego środowiska
```console
docker-compose -f docker-compose-prod.yml build --no-cache && docker-compose -f docker-compose-prod.yml up -d
```

## Uruchamianie środowiska cloudowego
### Wymagania przed wdrożeniem
Przed wdrożeniem do Cloud wymagana jest jakaś forma VM w cloud. W tym przypadku jest to `Digital Ocean Droplet` ale może być równie dobrze `AWS EC2`
Należy stworzyć `Droplet` w [Digital Ocean](https://www.digitalocean.com/products/droplets)
Następnie dodać jego dane w skrypcie `deploy.sh`, chodzi tu o zmienne `VM_USER` i `VM_HOST`
Dodatkowo należy przypisać do Droplet rekord DNS - w tym przypadku `jakwywioze.pl`. Można to zrobić po stworzeniu Droplet w zakładce `Networking`
Kolejnym krokiem będzie uruchomienie skryptu
```console
./deploy.sh
```

### Certyfikat SSL
Aby nasze środowisko Cloud miało szyfrowanie połączenie i obsługiwało protokuł `HTTPS` wymagany jest certyfikat `SSL`
Pomocny będzie tutaj [Certbot](https://certbot.eff.org/instructions?ws=nginx&os=ubuntufocal)
Gdy już wygenerujemy certyfikat SSL Frontend zacznie obsługiwać, jednakże dla Spring'a wymagany jest inny format klucza.
W tym celu skonwertujemy nasz klucz publiczny i prywatny w format `.p12`.
```console
openssl pkcs12 -export -inkey /etc/letsencrypt/live/www.jakwywioze.pl/privkey.pem -in /etc/letsencrypt/live/www.jakwywioze.pl/fullchain.pem -out /etc/letsencrypt/live/www.jakwywioze.pl/keystore.p12
```
Ostatnim krokiem będzie ponowne uruchomienie skryptu
```console
./deploy.sh
```
W tym momencie powinniśmy mieć w pełni wdrożoną aplikacje na środowisko cloudowe, obsługującą `HTTPS`.

## Architektura systemu
System składa się z czterech głównych komponentów, które są uruchamiane jako oddzielne usługi w środowisku Docker

### Baza danych
Usługa db to kontener Docker uruchamiający najnowszą wersję `PostgreSQL`. Kontener jest konfigurowany za pomocą zmiennych środowiskowych, 
które definiują nazwę użytkownika i hasło do bazy danych. Dane są przechowywane w woluminie Docker o nazwie db.

### Backend
Usługa backend to aplikacja `Spring Boot` uruchamiana w kontenerze Docker. Aplikacja komunikuje się z bazą danych PostgreSQL za pośrednictwem JDBC. 
Kontener jest konfigurowany za pomocą zmiennych środowiskowych, które definiują szczegóły połączenia z bazą danych, ustawienia sesji, adresy URL frontendu, dane do wysyłania e-maili, 
klucz API do geokodowania i ustawienia SSL.

### Frontend
Usługa frontend to aplikacja `Vue` + `TypeScript` uruchamiana w kontenerze Docker. Jako store używany jest tutaj `Pina.js`. Aplikacja komunikuje się z backendem za pośrednictwem HTTPS. 
Kontener jest konfigurowany za pomocą zmiennych środowiskowych, które definiują adresy URL backendu.

### Reversed proxy
Serwer `nginx` uruchamiany w kontenerze Docker. Serwer reversed proxy jest konfigurowany za pomocą pliku konfiguracyjnego `deafult.conf` i certyfikatów `SSL`, które są montowane jako woluminy. 

### Wdrożenie
System jest wdrażany na platformie Digital Ocean. Każda z usług jest uruchamiana jako oddzielny kontener Docker, co umożliwia łatwe skalowanie i zarządzanie systemem. 
Wszystkie usługi są zdefiniowane w pliku `docker-compose-prod.yml`, co ułatwia uruchomienie całego systemu jednym poleceniem.
`Docker` umożliwia izolację usług, co zwiększa bezpieczeństwo i niezawodność systemu. Ponadto, dzięki użyciu Dockera, system można łatwo przenieść na inną platformę lub uruchomić lokalnie do celów deweloperskich i testowych.

