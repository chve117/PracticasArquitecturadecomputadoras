library IEEE;
library work;
use IEEE.STD_LOGIC_1164.ALL;
use work.packageESCOMIPS.all;

entity dataPath is
  Port ( WPC, UP, DW : in STD_LOGIC;
           CLK, CLR : in STD_LOGIC;
           WR, SHE, DIR : in STD_LOGIC;
           ALUOP: in STD_LOGIC_VECTOR(3 downto 0);
           WD: in STD_LOGIC;
           SR2, SWD, SDMP, SEXT, SOP1, SOP2, SDMD, SR: in STD_LOGIC;
           OV, N, Z, C: out STD_LOGIC );
end dataPath;

architecture Behavioral of dataPath is
  signal programCounter : STD_LOGIC_VECTOR(15 downto 0);
  signal instruction: STD_LOGIC_VECTOR(24 downto 0);
  signal readData1: STD_LOGIC_VECTOR(15 downto 0);
  signal readData2: STD_LOGIC_VECTOR(15 downto 0);
  signal ALUResult: STD_LOGIC_VECTOR(15 downto 0);
  signal extendedNumber: STD_LOGIC_VECTOR(15 downto 0);
  signal extendedAddress: STD_LOGIC_VECTOR(15 downto 0);
  signal extendedOpB: STD_LOGIC_VECTOR(15 downto 0);
  signal dataMemOut: STD_LOGIC_VECTOR(15 downto 0);
  signal muxToPilaPCin : STD_LOGIC_VECTOR(15 downto 0);
  signal muxToReadReg2: STD_LOGIC_VECTOR(3 downto 0);
  signal muxToWriteDataReg: STD_LOGIC_VECTOR(15 downto 0);
  signal muxFromDataOutMemory: STD_LOGIC_VECTOR(15 downto 0);
  signal muxToALUA: STD_LOGIC_VECTOR(15 downto 0);
  signal muxToALUB: STD_LOGIC_VECTOR(15 downto 0);
  signal muxToMemData: STD_LOGIC_VECTOR(15 downto 0);
  
begin
   --Pila
pila: pilaHardware PORT MAP
         ( PCin => muxToPilaPCin,
           DW => DW,
           UP => UP,
           WPC => WPC,
           clk => CLK,
           clr => CLR,
           PCout => programCounter
         );
         
--Memoria de Programa
memProgram: memoryProgram PORT MAP
        (
            PC => programCounter(9 downto 0),
            Inst => instruction
        );
        
--MUXES antes de registros
muxReadReg2: mux4Bits PORT MAP
        (
            dataIn1 => instruction(11 downto 8),
            dataIn2 => instruction(19 downto 16),
            sel => SR2,
            dataOut => muxToReadReg2
        );       

muxWriteData: mux16Bits PORT MAP
        (
            dataIn1 => instruction(15 downto 0),
            dataIn2 => muxFromDataOutMemory,
            sel => SWD,
            dataOut => muxToWriteDataReg
        );   
        
muxPilaPCin: mux16Bits PORT MAP
        (
            dataIn1 => instruction(15 downto 0),
            dataIn2 => muxFromDataOutMemory,
            sel => SDMP,
            dataOut => muxToPilaPCin
        );   
                
--Archivo de Registros
ArchReg: archivoRegistros PORT MAP
         ( writeReg => instruction(19 downto 16),
           writeData => muxToWriteDataReg,
           readReg1 => instruction(15 downto 12),
           readReg2 => muxToReadReg2,
           shamt => instruction(7 downto 4),
           clk => CLK,
           clr => CLR,
           WR => WR,
           SHE => SHE,
           DIR => DIR,
           readData1 => readData1,
           readData2 => readData2
         );
         
--Extensores         
signExt: signExtender PORT MAP
       ( normalNumber => instruction(11 downto 0),
         extendedNumber => extendedNumber
       );
       
addressExt: addressExtensor PORT MAP
       ( normalAddress => instruction(11 downto 0),
         extendedAddress => extendedAddress
       );
       
--MUXES ANTES DE ALU       
muxExtensor: mux16Bits PORT MAP
        (
            dataIn1 => extendedNumber,
            dataIn2 => extendedAddress,
            sel => SEXT,
            dataOut => extendedOpB
        );   
        
muxALUA: mux16Bits PORT MAP
        (
            dataIn1 => readData1,
            dataIn2 => programCounter,
            sel => SOP1,
            dataOut => muxToALUA
        );     

muxALUB: mux16Bits PORT MAP
        (
            dataIn1 => readData2,
            dataIn2 => extendedOpB,
            sel => SOP2,
            dataOut => muxToALUB
        );                 
        
--ALU
ALU: ALU16Bits PORT MAP
      ( ALUOP => ALUOP,
        a => muxToALUA,
        b => muxToALUB,
        s => ALUResult,
        OV => OV,
        N => N,
        Z => Z,
        C => C
      );
      
--MUX antes de Memoria de Datos      
muxMemDataAddress: mux16Bits PORT MAP
        (
            dataIn1 => ALUResult,
            dataIn2 => instruction(15 downto 0),
            sel => SDMD,
            dataOut => muxToMemData
        );    
              
--Memoria de Datos
memData: memoryData PORT MAP
        ( dir => muxToMemData(9 downto 0),
          dataIn => readData2,
          clk => CLK,
          wd => WD,
          dataOut => dataMemOut
        );      
        
--MUX despues de Memoria de Datos
muxMemDataOut: mux16Bits PORT MAP
        (
            dataIn1 => dataMemOut,
            dataIn2 => ALUResult,
            sel => SR,
            dataOut => muxFromDataOutMemory
        );
                   
end Behavioral;
