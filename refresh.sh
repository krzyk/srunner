#!/bin/sh
set -e
set -x

curl -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36' -H 'Accept: application/json, text/plain, */*' --compressed -H "X-Csrf-Token: $C1" -H 'Connection: keep-alive' -H 'Referer: https://pacje''nt.erejes''tracja.ezd''rowie.go''v.pl/wizyty' -H "Cookie: patient_sid=$S1" -H 'Sec-Fetch-Dest: empty' -H 'Sec-Fetch-Mode: cors' -H 'Sec-Fetch-Site: same-origin' -H 'TE: Trailers' 'https://pac''jent.ere''jestracja.ezd''rowie.g''ov.pl/api/settings'
