Funkcje znakowe języka SQL

1. Usuń przerwy w imionach i nazwiskach 
ROZWIĄZANIE: 
SELECT
REPLACE
    (klienci.imie_klienta, ' ', '') 'imie',
REPLACE
    (klienci.nazwisko_klienta, ' ', '') 'nazwisko'
FROM
    klienci;

2. Wyświetl imiona i nazwiska klinetów bez nadmiarowych spacji, oraz miasta z jakich pochodzą.
Wyniki posortuj malejąco według liczby znaków w kolumnie miasto. 
ROZWIĄZANIE: 
SELECT
REPLACE
    (klienci.imie_klienta, ' ', '') AS imie,
REPLACE
    (klienci.nazwisko_klienta, ' ', '') AS nazwisko,
    klienci.miasto_klienta AS miasto
FROM
    klienci
ORDER BY
    CHAR_LENGTH(klienci.miasto_klienta)
DESC
    ;

3. Zakatualizuj rekordy w tabeli klienci pozbywając się nadmierowych spacji w kolumnach imię i nazwisko 
ROZIWĄZANIE: 
UPDATE
    klienci
SET
    klienci.id_klienta =
REPLACE
    (klienci.imie_klienta, ' ', ''),
    klienci.nazwisko_klienta = TRIM(klienci.nazwisko_klienta);

4. Wyświetl nazwy domen w jakich klienci mają adresy e-mail
ROZWIĄZANIE:
SELECT DISTINCT
    SUBSTRING(
        klienci.email_klienta,
        INSTR(klienci.email_klienta, '@') +1
    ) 'domena'
FROM
    klienci;

5. Wyświetl w jednej kolumnie imiona i nazwiska klientów z dołączoną formą grzecznościową
ROZWIĄZANIE: 
SELECT
    CONCAT(
        IF(klienci.plec = 'M', 'Pan ', 'Pani '),
        klienci.imie_klienta,
        ' ',
        klienci.nazwisko_klienta
    ) AS klienci
FROM
    klienci
ORDER BY
    klienci;

6. Stwórz zapytanie, które zwróci nam: w pierwszej kolumnie markę i model samochu a w drugiej 
ile "raz" lub "razy" został wypożyczony.
ROZWIĄZNIE: 
SELECT
    CONCAT(
        IF(
            CHAR_LENGTH(samochody.marka) <= 3,
            UCASE(samochody.marka),
            CONCAT(
                UCASE(LEFT(samochody.marka, 1)),
                SUBSTRING(samochody.marka, 2)
            )
        ),
        ' ',
        samochody.model
    ) AS Auto,
    CONCAT(
        COUNT(
            dane_wypozyczen.id_wypozyczenia
        ),
        CASE WHEN COUNT(
            dane_wypozyczen.id_wypozyczenia
        ) = 1 THEN ' Raz' ELSE ' Razy'
    END
) AS ilosc
FROM
    samochody
LEFT JOIN dane_wypozyczen ON samochody.id_samochodu = dane_wypozyczen.id_samochodu
GROUP BY
    samochody.id_samochodu,
    samochody.marka,
    samochody.model
ORDER BY
    COUNT(
        dane_wypozyczen.id_wypozyczenia
    )
DESC
    ;