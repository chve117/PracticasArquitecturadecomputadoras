library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALU1Bit is
    Port ( selA : in STD_LOGIC;
           selB : in STD_LOGIC;
           op : in STD_LOGIC_VECTOR (1 downto 0);
           a : in STD_LOGIC;
           b : in STD_LOGIC;
           Cin : in STD_LOGIC;
           res : out STD_LOGIC;
           Cout : out STD_LOGIC);
end ALU1Bit;

architecture Behavioral of ALU1Bit is

component Sumador1Bit is
    Port ( a,b,Cin : in STD_LOGIC;
           S,Cout : out STD_LOGIC);
end component;
signal auxA, auxB, auxAND, auxOR, auxXOR, auxSuma, auxCout: STD_LOGIC;
begin
    auxA<=a xor selA;
    auxB<=b xor selB;
    
    auxAND<=auxA and auxB;
    auxOR<=auxA or auxB;
    auxXOR<=auxA xor auxB;
    
    sumador: Sumador1Bit 
    Port map(
        a => auxA,
        b => auxB,
        Cin => Cin,
        S => auxSuma,
        Cout => auxCout
        );
        
    MUXOP: process (auxAND, auxOR, auxXOR, auxSUMA, op)
    begin
        case op is
            when "00" => res <= auxAND;
            when "01" => res <= auxOR;
            when "10" => res <= auxXOR;
            when others => res <= auxSUMA;
        end case;
    end process MUXOP;
    Cout <= op(0) and op(1) and auxCout;
end Behavioral;


