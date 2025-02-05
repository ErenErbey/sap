REPORT z_deneme_0013.

DATA:gt_tb1_t TYPE TABLE OF bkpf,
     gt_tb2_t TYPE TABLE OF bsid_VIEW,
     gt_tb3_t TYPE TABLE OF t003t,
     wa_bkpf  TYPE bkpf,
     wa_bsid  TYPE bsid_VIEW,
     wa_t003t TYPE t003t.


START-OF-SELECTION.

  SELECT * FROM bkpf
    INTO TABLE gt_tb1_t.

  SELECT * FROM bsid_VIEW
    INTO TABLE @gt_tb2_t.

  SELECT * FROM t003t
INTO TABLE @gt_tb3_t.

  WRITE AT 1 'BELGE NO' .
  WRITE AT 20 'MÜŞTERİ NO' .
  WRITE AT 40 'BELGE TARİHİ' .
  WRITE AT 60 'KAYIT TARİHİ' .
  WRITE AT 80 'PARA BİRİMİ' .
  WRITE AT 100 'BELGE TÜRÜ' .
  WRITE AT 120 'TANIM' .
  NEW-LINE.

  LOOP AT gt_tb1_t INTO wa_bkpf.


    READ TABLE gt_tb2_t INTO wa_bsid WITH KEY belnr = wa_bkpf-belnr.

  READ TABLE gt_tb3_t INTO wa_t003t WITH KEY blart = wa_bkpf-blart spras = 'TR'.


    WRITE :/ wa_bkpf-belnr .
    WRITE : AT 20 wa_bsid-kunnr .
    WRITE : AT 40 wa_bsid-bldat .
    WRITE : AT 60 wa_bsid-budat .
    WRITE : AT 80 wa_bsid-waers .
    WRITE : AT 100 wa_bkpf-blart .
    WRITE : AT 120 wa_t003t-ltext .
  ENDLOOP.

END-OF-SELECTION.
