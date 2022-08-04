library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity Contador is
    Port ( LB : in STD_LOGIC;
           EB : in STD_LOGIC;
           clk : in STD_LOGIC;
           clr : in STD_LOGIC;
           QB : out STD_LOGIC_VECTOR (3 downto 0));
end Contador;

architecture Behavioral of Contador is
signal cont: STD_LOGIC_VECTOR(3 downto 0);
begin

    process(clk,clr)
    begin
        if(clr='1') then --Reset
            cont<="0000";
        elsif(rising_edge(clk)) then
            if(LB='1') then --Carga
                cont<="0000";
            elsif(EB='1') then --Incremento
                cont<=cont + 1;
            end if;
        end if;
    end process;

    QB<=cont;

end Behavioral;