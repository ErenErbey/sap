*&---------------------------------------------------------------------
*& Report Z_DENEME_0010
*&---------------------------------------------------------------------
*&
*&---------------------------------------------------------------------

"değişken tanımları gv_trh1:girişe kapalı olan ve sistem tarihine ayarlı olan değişken.
"gv_trh2 girişe açık olan sistem tairihnden 180 gün öncesini defaultladığım değişken
"atrh:ilk tarih ve ikinci tarihin arasındaki günler ve aylar (gv_ay lv_gun değişkenleri bundan yola çıkarak hazırlandı.)
"lv_guntrh_index:tarihin gün kısmını pazartesi vb string ifadelere çevirmek için kullandığım değişken

REPORT z_deneme_0010.




PARAMETERS: gv_trh1 TYPE sy-datum DEFAULT sy-datum OBLIGATORY MODIF ID sys,
            gv_trh2 TYPE sy-datum DEFAULT sy-datum OBLIGATORY MODIF ID syc.




AT SELECTION-SCREEN OUTPUT.
"ilk parametreyi sistem tarihine ve ikincisini sistemden 180 gün öncesine ayarladığım kod
  LOOP AT SCREEN.
    IF screen-name = 'GV_TRH1'.
      screen-input  = 0 .
      gv_trh2 = sy-datum - 180.
      MODIFY SCREEN.
    ENDIF.



  ENDLOOP.


START-OF-SELECTION.
"tarihlerin arasındaki kuralları yazdığım kısım
  IF gv_trh2 >= gv_trh1.
    MESSAGE 'Daha büyük tarih seçemezsin' TYPE 'E'.
  ENDIF.

  DATA: lv_guntrhfrk TYPE i.
  lv_guntrhfrk = gv_trh1 - gv_trh2.

  IF lv_guntrhfrk < 180.
    MESSAGE 'Girilen tarih en az 6 ay küçük olmalı' TYPE 'E'.
  ENDIF.



  DATA: gv_atrh         TYPE sy-datum,
        lv_guntrh       TYPE int4,
        gv_ay           TYPE string,
        lv_guntrh_index TYPE i VALUE 1,
        lt_gunler       TYPE TABLE OF char10,
        lv_gun          TYPE char10,
        gv_tmtrh        TYPE char10.
"günleri ekrana yazdırdığım ve başlangıç tarini indexlediğim kısım
  WRITE AT 10:     'PAZARTESİ:' .
  WRITE AT 30:     'SALI:' .
  WRITE AT 50 :    'ÇARŞAMBA:' .
  WRITE AT 70 :    'PERŞEMBE:' .
  WRITE AT 90:     'CUMA:' .
  WRITE AT 110:     'CUMARTESİ:' .
  WRITE AT 130:     'PAZAR:' .
  new-line.
  lt_gunler = VALUE #(
    ( 'PZT' )
    ( 'SAL' )
    ( 'ÇARŞ' )
    ( 'PERŞ' )
    ( 'CUM' )
    ( 'CMT' )
    ( 'PZR' )
  ).

  gv_atrh = gv_trh2.



  lv_guntrh = gv_atrh+6(2).
  gv_ay = gv_atrh+4(2).


  " Gün döngüsü
  WHILE gv_atrh < gv_trh1.
    gv_atrh = gv_atrh + 1.

    lv_guntrh_index = lv_guntrh_index + 1.

    IF lv_guntrh_index > 8.
      lv_guntrh_index = 1.
    ENDIF.


  READ TABLE lt_gunler INDEX lv_guntrh_index INTO lv_gun.

    lv_guntrh = gv_atrh+6(2).
    gv_ay = gv_atrh+4(2).

    CASE gv_ay.
      WHEN '01'. gv_ay = 'OCK.'.
      WHEN '02'. gv_ay = 'ŞBT.'.
      WHEN '03'. gv_ay = 'MRT.'.
      WHEN '04'. gv_ay = 'NSN.'.
      WHEN '05'. gv_ay = 'MYS'.
      WHEN '06'. gv_ay = 'HZN'.
      WHEN '07'. gv_ay = 'TMZ'.
      WHEN '08'. gv_ay = 'AĞT'.
      WHEN '09'. gv_ay = 'EyL'.
      WHEN '10'. gv_ay = 'EkM'.
      WHEN '11'. gv_ay = 'KSM'.
      WHEN '12'. gv_ay = 'ARK'.
    ENDCASE.




    CASE lv_guntrh_index.
  WHEN 1.
    WRITE: / lv_guntrh, gv_ay, lv_gun. " Pazartesi
  WHEN 2.
    WRITE: AT 20 lv_guntrh, gv_ay, lv_gun. " Salı
  WHEN 3.
    WRITE: AT 40 lv_guntrh, gv_ay, lv_gun. " Çarşamba
  WHEN 4.
    WRITE: AT 60 lv_guntrh, gv_ay, lv_gun. " Perşembe
  WHEN 5.
    WRITE: AT 80 lv_guntrh, gv_ay, lv_gun. " Cuma
  WHEN 6.
    WRITE: AT 100 lv_guntrh, gv_ay, lv_gun. " Cumartesi
  WHEN 7.
    WRITE: AT 120 lv_guntrh, gv_ay, lv_gun. " Pazar
    NEW-LINE.
ENDCASE.










  ENDWHILE.



END-OF-SELECTION.
