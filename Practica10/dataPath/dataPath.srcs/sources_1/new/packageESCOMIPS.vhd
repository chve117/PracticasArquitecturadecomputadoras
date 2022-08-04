library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package packageESCOMIPS is
--  Port ( );
--MUX 4 bits
 component mux4Bits is
   Port(dataIn1 : in std_logic_vector (3 downto 0);
        dataIn2 : in std_logic_vector (3 downto 0);
        sel : in std_logic;
        dataOut : out std_logic_vector(3 downto 0));
end component;
--MUX 16 BITS
component mux16Bits is
    Port ( dataIn1 : in STD_LOGIC_VECTOR (15 downto 0);
           dataIn2 : in STD_LOGIC_VECTOR (15 downto 0);
           sel : in STD_LOGIC;
           dataOut : out STD_LOGIC_VECTOR (15 downto 0));
end component;
--PILA HARDWARE
component pilaHardware is
    Port ( PCin : in STD_LOGIC_VECTOR (15 downto 0);
           DW : in STD_LOGIC;
           UP : in STD_LOGIC;
           WPC : in STD_LOGIC;
           clk : in STD_LOGIC;
           clr : in STD_LOGIC;
           PCout : out STD_LOGIC_VECTOR (15 downto 0));
end component;
--memoria programa
component memoryProgram is
    generic(
        p: integer := 10; -- p=log_2(m) = log_2(2048) = 11
        n: integer := 25
    );
    Port (
        PC : in STD_LOGIC_VECTOR(p-1 downto 0);
        Inst: out STD_LOGIC_VECTOR(n-1 downto 0));
end component;
--Archivo de registros
component archivoRegistros is
    Port ( writeReg : in STD_LOGIC_VECTOR (3 downto 0);
           writeData : in STD_LOGIC_VECTOR (15 downto 0);
           readReg1 : in STD_LOGIC_VECTOR (3 downto 0);
           readReg2 : in STD_LOGIC_VECTOR (3 downto 0);
           shamt : in STD_LOGIC_VECTOR (3 downto 0);
           clk : in STD_LOGIC;
           clr : in STD_LOGIC;
           WR : in STD_LOGIC;
           SHE : in STD_LOGIC;
           DIR : in STD_LOGIC;
           readData1 : out STD_LOGIC_VECTOR (15 downto 0);
           readData2 : out STD_LOGIC_VECTOR (15 downto 0));
end component;
--Alu de 16 bits
component ALU16Bits is
    Port ( ALUOP : in STD_LOGIC_VECTOR (3 downto 0);
           a : in STD_LOGIC_VECTOR (15 downto 0);
           b : in STD_LOGIC_VECTOR (15 downto 0);
           S : out STD_LOGIC_VECTOR (15 downto 0);
           OV : out STD_LOGIC;
           N : out STD_LOGIC;
           Z : out STD_LOGIC;
           C : out STD_LOGIC);
end component;
--Extensor de Signo
component signExtender is
    Port ( normalNumber : in STD_LOGIC_VECTOR (11 downto 0);
           extendedNumber : out STD_LOGIC_VECTOR (15 downto 0));
end component;

--Extensor de Dirección
component addressExtensor is
    Port ( normalAddress : in STD_LOGIC_VECTOR (11 downto 0);
           extendedAddress : out STD_LOGIC_VECTOR (15 downto 0));
end component;

 --Memoria de programa
 component memoryData is
    generic(
        p: integer := 10; -- p=log_2(m) = log_2(2048) = 11
        n: integer := 16 
    );
    Port (
        dir : in STD_LOGIC_VECTOR(p-1 downto 0);
        dataIn: in STD_LOGIC_VECTOR (n-1 downto 0);
        clk, wd : in STD_LOGIC;
        dataOut: out STD_LOGIC_VECTOR(n-1 downto 0));
end component;
end package;
