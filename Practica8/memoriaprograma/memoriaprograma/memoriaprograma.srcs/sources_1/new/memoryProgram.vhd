library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity memoryProgram is
    generic(
        p: integer := 10; -- p=log_2(m) = log_2(2048) = 11
        n: integer := 25
    );
    Port (
        PC : in STD_LOGIC_VECTOR(p-1 downto 0);
        Inst: out STD_LOGIC_VECTOR(n-1 downto 0));
end memoryProgram;

architecture Behavioral of memoryProgram is

constant OP_R : STD_LOGIC_VECTOR(4 downto 0):= "00000"; --OPCODE INSTRUCCIONES R
constant SU: STD_LOGIC_VECTOR(3 downto 0):= "0000";


constant F_ADD: STD_LOGIC_VECTOR(3 downto 0):= "0000";
constant F_SUB: STD_LOGIC_VECTOR(3 downto 0):= "0001";
constant F_AND: STD_LOGIC_VECTOR(3 downto 0):= "0010";
constant F_OR: STD_LOGIC_VECTOR(3 downto 0):= "0011";
constant F_XOR: STD_LOGIC_VECTOR(3 downto 0):= "0100";
constant F_NAND: STD_LOGIC_VECTOR(3 downto 0):= "0101";
constant F_NOR: STD_LOGIC_VECTOR(3 downto 0):= "0110";
constant F_XNOR: STD_LOGIC_VECTOR(3 downto 0):= "0111";
constant F_NOT: STD_LOGIC_VECTOR(3 downto 0):= "1000";


constant LI: STD_LOGIC_VECTOR(4 downto 0):= "00001";
constant LWI: STD_LOGIC_VECTOR(4 downto 0):= "00010";
constant LW: STD_LOGIC_VECTOR(4 downto 0):= "10111";
constant SWI: STD_LOGIC_VECTOR(4 downto 0):= "00011";
constant SW: STD_LOGIC_VECTOR(4 downto 0):= "00100";
constant ADDI: STD_LOGIC_VECTOR(4 downto 0):= "00101";
constant SUBI: STD_LOGIC_VECTOR(4 downto 0):= "00110";
constant ANDI: STD_LOGIC_VECTOR(4 downto 0):= "00111";
constant ORI: STD_LOGIC_VECTOR(4 downto 0):= "01000";
constant XORI: STD_LOGIC_VECTOR(4 downto 0):= "01001";
constant NANDI: STD_LOGIC_VECTOR(4 downto 0):= "01010";
constant NORI: STD_LOGIC_VECTOR(4 downto 0):= "01011";
constant XNORI: STD_LOGIC_VECTOR(4 downto 0):= "01100";
constant BEQI: STD_LOGIC_VECTOR(4 downto 0):= "01101";
constant BNEI: STD_LOGIC_VECTOR(4 downto 0):= "01110";
constant BLTI: STD_LOGIC_VECTOR(4 downto 0):= "01111";
constant BLETI: STD_LOGIC_VECTOR(4 downto 0):= "10000";
constant BGTI: STD_LOGIC_VECTOR(4 downto 0):= "10001";
constant BGETI: STD_LOGIC_VECTOR(4 downto 0):= "10010";

--CONSTANTES DE INSTRUCCIONES TIPO J
constant B: STD_LOGIC_VECTOR(4 downto 0):= "10011";
constant CALL: STD_LOGIC_VECTOR(4 downto 0):= "10100";

--CONSTANTES DE OTRAS INSTRUCCIONES 
constant RET: std_logic_vector(24 downto 0):="1010100000000000000000000";
constant NOP: std_logic_vector(24 downto 0):="1011000000000000000000000";

constant R0: STD_LOGIC_VECTOR(3 downto 0):= "0000";
constant R1: STD_LOGIC_VECTOR(3 downto 0):= "0001";
constant R2: STD_LOGIC_VECTOR(3 downto 0):= "0010";
constant R3: STD_LOGIC_VECTOR(3 downto 0):= "0011";
constant R4: STD_LOGIC_VECTOR(3 downto 0):= "0100";
constant R5: STD_LOGIC_VECTOR(3 downto 0):= "0101";
constant R6: STD_LOGIC_VECTOR(3 downto 0):= "0110";
constant R7: STD_LOGIC_VECTOR(3 downto 0):= "0111";
constant R8: STD_LOGIC_VECTOR(3 downto 0):= "1000";
constant R9: STD_LOGIC_VECTOR(3 downto 0):= "1001";
constant R10: STD_LOGIC_VECTOR(3 downto 0):= "1010";
constant R11: STD_LOGIC_VECTOR(3 downto 0):= "1011";
constant R12: STD_LOGIC_VECTOR(3 downto 0):= "1100";
constant R13: STD_LOGIC_VECTOR(3 downto 0):= "1101";
constant R14: STD_LOGIC_VECTOR(3 downto 0):= "1110";
constant R15: STD_LOGIC_VECTOR(3 downto 0):= "1111";


type matrix is array (0 to (2**p)-1) of STD_LOGIC_VECTOR(n-1 downto 0);
constant memory : matrix := (
    LI & R0 & x"0000", --LI R0, 0
    LI & R1 & x"0001", --LI R1, 1
    LI & R2 & x"0000", --LI R2, 0
    LI & R3 & x"000C", --LI R3, 12
    OP_R & R4 & R0 & R1 & SU & f_ADD,--ADD R4,R0,R1
    SWI & R4 & x"0048",--SWI R4, 72
    ADDI & R0 & R1 & x"000",-- ADDI R0, R1, #0
    ADDI & R1 & R4 & x"000",-- ADDI R1, R4, #0
    ADDI & R2 & R2 & x"001",-- ADDI R2, R2, #1
    BNEI & R3 & R2 & x"FFB",-- BNEI R3, R2, -5
    NOP, --NOP
    B & SU & x"000A", --B 10
    others => (others=> '0')
);
begin

    Inst <=memory(conv_integer(PC));

end Behavioral;