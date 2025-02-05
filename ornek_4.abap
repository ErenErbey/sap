*&---------------------------------------------------------------------
*& Report Z_DENEME_0015
*&---------------------------------------------------------------------
*&
*&---------------------------------------------------------------------
REPORT z_deneme_0015.

TYPES: BEGIN OF ty_bkpf_bsid,
         belnr TYPE bkpf-belnr,
         bldat TYPE bsid_view-bldat,
         budat TYPE bsid_view-budat,
         waers TYPE bsid_view-waers,
         blart TYPE bsid_view-blart,
         bukrs TYPE bkpf-bukrs,
         kunnr TYPE bsid_view-kunnr,
       END OF ty_bkpf_bsid.

DATA:
  wa_bsid  TYPE bsid_VIEW,
  gt_tb1_t TYPE TABLE OF ty_bkpf_bsid,
  gt_tb2_t TYPE TABLE OF   t003t,
  gs_tb1_t TYPE  ty_bkpf_bsid,
  wa_t003t TYPE t003t,
  go_salv  TYPE REF TO  cl_salv_table.

SELECTION-SCREEN ULINE.
PARAMETERS: gv_blgno TYPE bkpf-belnr OBLIGATORY,
            gv_srktn TYPE bkpf-bukrs DEFAULT 4000,
            gv_mlyl  TYPE bkpf-gjahr DEFAULT 2024.


AT SELECTION-SCREEN OUTPUT.

  LOOP AT SCREEN.
    IF screen-name = 'GV_SRKTN'.
      screen-input = 0.
    ENDIF.
    IF screen-name = 'GV_MLYL'.
      screen-input = 0.
    ENDIF.
    MODIFY SCREEN.
  ENDLOOP.

START-OF-SELECTION.

  SELECTION-SCREEN ULINE.

  PARAMETERS: p_rad1 RADIOBUTTON GROUP  gr1,
              p_rad2 RADIOBUTTON GROUP gr1.


  SELECT a~belnr , b~bldat, b~budat, b~waers, b~blart,
         a~bukrs, b~kunnr
    FROM bkpf AS a
inner JOIN bsid_VIEW AS b
    ON a~belnr = b~belnr
    WHERE a~belnr = @gv_blgno
      AND a~gjahr = @gv_mlyl
    INTO TABLE @gt_tb1_t up to 20 rows .

  SELECT * FROM t003t
INTO TABLE @gt_tb2_t.




  IF  p_rad1 = 'X'  .
    LOOP AT gt_tb1_t INTO gs_tb1_t.

READ TABLE gt_tb2_t INTO wa_t003t WITH KEY blart = gs_tb1_t-blart spras = 'TR'.


      WRITE : /  gs_tb1_t-belnr.
      WRITE : AT 20  gs_tb1_t-bukrs. " Şirket Kodu
      WRITE : AT 40  gs_tb1_t-bldat. " Belge Tarihi
      WRITE : AT 60  gs_tb1_t-budat. " Belge Tarih
      WRITE : AT 80  gs_tb1_t-waers. " Para Birimi
      WRITE : AT 100  gs_tb1_t-blart. " Belge Türü
       WRITE : AT 120 wa_t003t-ltext .
    ENDLOOP.

  ENDIF.


  IF p_rad2 = 'X'.

    cl_salv_table=>factory(

    IMPORTING    r_salv_table = go_salv
    CHANGING
      t_table        =  gt_tb1_t
  ).
    go_salv->display( ).

  ENDIF.
