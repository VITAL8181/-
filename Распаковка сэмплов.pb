
Enumeration
  #File
EndEnumeration

Structure smpstr
  fregflag.a
  smeshenie.l
  skip.u
  size.u
  loop.u
  endfile.u
  sampledate.l
EndStructure
Global Dim Samples.smpstr(0)

; If ReadFile (#File, "C:\GEMSDATABASE\zerotol\samples.bin")
If ReadFile (#File, "C:\DISTR\SERECASOFT\Zero Tolerance\RUS\Zero Tolerance (RUS) - 04 Samples")
  
  flag.a     = ReadAsciiCharacter(#File)
  
  smeshenie1 = ReadAsciiCharacter(#File)
  smeshenie2 = ReadAsciiCharacter(#File)
  smeshenie3 = ReadAsciiCharacter(#File)
  
  smeshenie = smeshenie3 << 16 + smeshenie2 << 8 + smeshenie1
  Debug Hex (smeshenie)
  
  vsegosamples = smeshenie / 12
  
  ReDim Samples (vsegosamples)
  
  Samples(1)\fregflag  = flag
  Samples(1)\smeshenie = smeshenie
  
  Samples(1)\skip      = ReadUnicodeCharacter(#File)
  Samples(1)\size      = ReadUnicodeCharacter(#File)
  Samples(1)\loop      = ReadUnicodeCharacter(#File)
  Samples(1)\endfile   = ReadUnicodeCharacter(#File)
  
  For i = 2 To vsegosamples
    Samples(i)\fregflag = ReadAsciiCharacter(#File)
    
    smeshenie1 = ReadAsciiCharacter(#File)
    smeshenie2 = ReadAsciiCharacter(#File)
    smeshenie3 = ReadAsciiCharacter(#File)
    smeshenie = smeshenie3 << 16 + smeshenie2 << 8 + smeshenie1
    
    Samples (i)\smeshenie = smeshenie
    
    Samples(i)\skip      = ReadUnicodeCharacter(#File)
    Samples(i)\size      = ReadUnicodeCharacter(#File)
    Samples(i)\loop      = ReadUnicodeCharacter(#File)
    Samples(i)\endfile   = ReadUnicodeCharacter(#File)
  Next
  
  For i = 1 To vsegosamples
    
    ;     резервирование памяти
    If Samples(i)\size
      Samples(i)\sampledate = AllocateMemory(Samples(i)\size)
      
      If Samples(i)\sampledate
        
        ReadData (#File, Samples (i)\sampledate, Samples(i)\size)
        
      EndIf
      ;       Else
      ;       Debug i
    EndIf
    
      
        
    
    CloseFile (#File)
    
    Delay(5)
    
    ;     savefilepath$ = "C:\GEMSDATABASE\Tut\zerotol\Samples\sample_"
    savefilepath$ = "C:\DISTR\SERECASOFT\Zero Tolerance\RUS\Samples\sample_"
    
    For i = 1 To vsegosamples
      
      filename$ = RSet(Hex(i-1), 2, "0") ; на будующие тут -1 наверное надобчтобы с 0 начиналось
      
      ;       создание sfx
      If CreateFile(#File, savefilepath$ + filename$ + ".sfx")
        
        WriteStringN(#File, "RAW 'sample_" + filename$ + ".snd'", #PB_Ascii)
        
        WriteStringN(#File, "FLAGS =$" + RSet(Hex(Samples(i)\fregflag), 2, "0"), #PB_Ascii)
        
        WriteStringN(#File, "SKIP  =$" + RSet(Hex(Samples(i)\skip, #PB_Unicode), 4, "0"),#PB_Ascii)
        
        WriteStringN(#File, "FIRST =$" + RSet(Hex(Samples(i)\size, #PB_Unicode), 4, "0"),#PB_Ascii)
        
        WriteStringN(#File, "LOOP  =$" + RSet(Hex(Samples(i)\loop, #PB_Unicode), 4, "0"),#PB_Ascii)
        
        WriteStringN(#File, "END   =$" + RSet(Hex(Samples(i)\endfile, #PB_Unicode), 4, "0"),#PB_Ascii)
        
        CloseFile(#File)
        
        Delay(5)
        
        If CreateFile(#File, savefilepath$ + filenane$ + ".snd")
          
          If Samples(i)\size
            WriteData(#File, Samples(i)\sampledate, Samples(i) \size)
          EndIf
          
          
          
    
    
    
 
        
     
      
; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 118
; FirstLine = 89
; EnableXP
; Executable = Распаковка сэмплов.pb.exe