*&---------------------------------------------------------------------*
*& Report Z_DENEME_0007
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_deneme_0007.
PARAMETERS: gv_say1 TYPE i,
            gv_say2 TYPE i.

DATA: i       TYPE i,
      gv_asal TYPE bool,

      j  TYPE i.




START-OF-SELECTION.
  PARAMETERS: p_rad1 RADIOBUTTON GROUP gr1,
              p_rad2 RADIOBUTTON GROUP gr1,
              p_rad3 RADIOBUTTON GROUP gr1,
              p_rad4 RADIOBUTTON GROUP gr1.





  IF p_rad1 EQ abap_true.

    DO gv_say2 -  gv_say1 + 1 TIMES.
      i =  gv_say1 + sy-index - 1.


      IF i MOD 2 = 0.
        WRITE: / i.

      ENDIF.
    ENDDO.
  ENDIF.




  IF p_rad2 EQ abap_true.

    DO gv_say2 -  gv_say1 + 1 TIMES.
      i =  gv_say1 + sy-index - 1.


      IF i MOD 2 = 1.
        WRITE: / i.

      ENDIF.
    ENDDO.
  ENDIF.


  IF p_rad3 EQ abap_true.

    DO gv_say2 -  gv_say1 + 1 TIMES.
      i =  gv_say1 + sy-index - 1.


      IF i MOD 7 = 0.
        WRITE: / i.

      ENDIF.
    ENDDO.
  ENDIF.

  IF p_rad4 EQ abap_true.

   DO gv_say2 -  gv_say1 + 1 TIMES.
      i =  gv_say1 + sy-index - 1.

 IF
    i mod 2 = 1 .

      ENDIF.
    ENDDO.
  ENDIF.
