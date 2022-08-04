library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity Arreglo is
    Port ( DA : in STD_LOGIC_VECTOR (8 downto 0);
           LA : in STD_LOGIC;
           EA : in STD_LOGIC;
           clr : in STD_LOGIC;
           clk : in STD_LOGIC;
           QA : out STD_LOGIC_VECTOR (8 downto 0));
end Arreglo;

architecture Behavioral of Arreglo is
signal registro: STD_LOGIC_VECTOR(8 downto 0);
begin
    process(clk,clr)
    begin
        if(clr='1') then --Reset
            registro <= (others => '0');
        elsif(rising_edge(clk)) then
            if(LA='1') then --Carga
                registro <= DA; 
            elsif(EA='1') then --Corriemiento
                registro <= to_stdlogicvector(to_bitvector(registro) srl (1));
            end if;
        end if;    
    end process;
    
    QA<=registro;

end Behavioral;
